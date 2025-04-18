// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/screens/core/color.dart';
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
              ),
            ),
            Center(
              child: TaskScreen(
                title: "test",
                displayTasks: (taskState) => taskState.processingTasks,
              ),
            ),
            Center(
              child: TaskScreen(
                title: "test",
                displayTasks: (taskState) => taskState.completely,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (builderContext) =>
                      DialogNewTask(cubit: context.read<TaskCubit>()),
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class DialogNewTask extends StatefulWidget {
  TaskCubit cubit;

  DialogNewTask({Key? key, required this.cubit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DialogNewTaskState();
}

class _DialogNewTaskState extends State<DialogNewTask> {
  var titleControler = TextEditingController();
  var descriptionController = TextEditingController();
  var priority = TaskPriority.low;
  var status = TaskStatus.newTask;
  var colorDropDown = ColorDropDown();
  DateTime? deadLine = null;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Dialog(
      child: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: titleControler,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "title",
                ),
                validator: (value) {
                  if (value == null || value!.isEmpty)
                    return "title can't be null";
                  return null;
                },
              ),

              SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "description",
                ),
              ),
              SizedBox(height: 10),
              dropdownPriority(),
              SizedBox(height: 10),
              dropdownStatus(),
              SizedBox(height: 10),
              colorDropDown,
              SizedBox(height: 10),
              Text("deadline: ${deadLine.toString()}"),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  var pickDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050),
                    initialDate: DateTime.now(),
                  );

                  setState(() => deadLine = pickDate);
                },
                icon: Icon(Icons.calendar_today),
                label: Text("pick deadline"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    widget.cubit.addTask(
                      Task(
                        title: titleControler.text,
                        description: descriptionController.text,
                        priority: priority,
                        status: status,
                        color: colorDropDown.color.color,
                        deadLineDate: deadLine,
                        createDate: DateTime.now(),
                        editedDate: DateTime.now(),
                      ),
                    );
                  }
                },
                child: Text("add new"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownPriority() {
    priority = TaskPriority.low;

    final List<DropdownMenuEntry<TaskPriority>> menuEntries =
        UnmodifiableListView<DropdownMenuEntry<TaskPriority>>(
          TaskPriority.values.map<DropdownMenuEntry<TaskPriority>>(
            (priority) =>
                DropdownMenuEntry(value: priority, label: priority.name),
          ),
        );

    return DropdownMenu<TaskPriority>(
      initialSelection: priority,
      onSelected: (value) {
        priority = value!;
      },
      dropdownMenuEntries: menuEntries,
    );
  }

  Widget dropdownStatus() {
    status = TaskStatus.newTask;

    final List<DropdownMenuEntry<TaskStatus>> menuEntries =
        UnmodifiableListView<DropdownMenuEntry<TaskStatus>>(
          TaskStatus.values.map<DropdownMenuEntry<TaskStatus>>(
            (priority) => MenuEntry(value: priority, label: priority.name),
          ),
        );

    return DropdownMenu<TaskStatus>(
      initialSelection: status,
      onSelected: (value) {
        status = value!;
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}
