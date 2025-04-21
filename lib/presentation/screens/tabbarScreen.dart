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
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: TabBarExample(repository: repository),
    );
  }
}

class TabBarExample extends StatelessWidget {
  TaskRepository repository;
  final searchController = TextEditingController();
  TabBarExample({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Sample'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.cloud_outlined)),
              Tab(icon: Icon(Icons.beach_access_sharp)),
              Tab(icon: Icon(Icons.brightness_5_sharp)),
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
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
