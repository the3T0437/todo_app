// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/screens/core/dialog_Task.dart';
import 'package:todoapp/presentation/screens/taskScreen.dart';

class TabbarScreen extends StatefulWidget {
  TaskRepository repository;
  TabbarScreen({super.key, required this.repository});

  @override
  State<StatefulWidget> createState() =>
      _TabbarScreenState(repository: repository);
}

class _TabbarScreenState extends State<TabbarScreen> {
  TaskRepository repository;
  _TabbarScreenState({required this.repository});

  late TabController _tabController;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return TabbarBody(repository: repository);
  }
}

class TabbarBody extends StatelessWidget {
  TaskRepository repository;
  final searchController = TextEditingController();
  TabbarBody({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            tabs: <Widget>[
              Tab(text: "New", icon: Icon(Icons.content_copy_rounded)),
              Tab(text: "In Process", icon: Icon(Icons.av_timer)),
              Tab(text: "Done", icon: Icon(Icons.check_circle_outline)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: TaskScreen(
                title: "test",
                displayTasks: (taskState) => taskState.newTasks,
                searchController: searchController,
              ),
            ),
            Center(
              child: TaskScreen(
                title: "test",
                displayTasks: (taskState) => taskState.processingTasks,
                searchController: searchController,
              ),
            ),
            Center(
              child: TaskScreen(
                title: "test",
                displayTasks: (taskState) => taskState.completely,
                searchController: searchController,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (contextBuilder) => BlocProvider.value(
                    value: context.read<TaskCubit>(),
                    child: DialogTask(
                      onSubmit:
                          (task) => context.read<TaskCubit>().addTask(task),
                    ),
                  ),
            );
          },
          tooltip: 'Add new task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
