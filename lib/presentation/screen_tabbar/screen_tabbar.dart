// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart';
import 'package:todoapp/presentation/widgets/dialog_task.dart';
import 'package:todoapp/presentation/screen_tabbar/widgets/list_tasks.dart';

/// A widget that displays a tab bar with three tabs for new, processing, and completed tasks.
///
/// This widget is responsible for rendering a tab bar with three tabs for new, processing, and completed tasks.
/// It uses BLoC pattern for state management and updates the UI based on the current [TaskState].
///
/// The widget takes a [repository] parameter to display the task details.

class ScreenTabbar extends StatefulWidget {
  TaskRepository repository;
  ScreenTabbar({super.key, required this.repository});

  @override
  State<StatefulWidget> createState() =>
      _ScreenTabbarState(repository: repository);
}

class _ScreenTabbarState extends State<ScreenTabbar> {
  TaskRepository repository;
  _ScreenTabbarState({required this.repository});

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
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text('Todo App'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            padding: EdgeInsets.only(bottom: 10, right: 16, left: 16),
            splashBorderRadius: BorderRadius.all(Radius.circular(8)),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Color.fromARGB(255, 255, 193, 108),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            tabs: <Widget>[
              Tab(text: "New", icon: Icon(Icons.content_copy_rounded)),
              Tab(text: "Processing", icon: Icon(Icons.av_timer)),
              Tab(text: "Completed", icon: Icon(Icons.check_circle_outline)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ListTasks(
                displayTasks: (taskState) => taskState.newTasks,
                searchController: searchController,
              ),
            ),
            Center(
              child: ListTasks(
                displayTasks: (taskState) => taskState.processingTasks,
                searchController: searchController,
              ),
            ),
            Center(
              child: ListTasks(
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
