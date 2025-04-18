import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todoapp/domain/models/task.dart";
import "package:todoapp/presentation/bloc/task_cubit.dart";
import "package:todoapp/presentation/bloc/task_state.dart";

class TaskScreen extends StatelessWidget {
  final List<Task> Function(TaskState) displayTasks;
  const TaskScreen({
    super.key,
    required this.title,
    required this.displayTasks,
    required this.searchController,
  });
  final TextEditingController searchController;

  final String title;

  @override
  Widget build(BuildContext context) {
    return body();
    /*
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => context.read<TaskCubit>().addTask(Task(title: 'hello')),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
    */
  }

  Widget body() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var tasks = displayTasks(state);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: SearchBar(
                controller: searchController,
                onChanged:
                    (value) => context.read<TaskCubit>().setSearchString(
                      searchController.text,
                    ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return showATask(tasks[index], context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget showATask(Task task, BuildContext context) {
    return Card(
      elevation: 10,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 10,
                height: 80,
                color: task.color,
              ),
            ],
          ),
          Column(
            children: [
              Text(task.title),
              dropdownMenuStatus(task, context),
              Text(task.description),
              Text(task.deadLineDate.toString()),
            ],
          ),
        ],
      ),
    );
  }
}

const List<TaskStatus> list = <TaskStatus>[
  TaskStatus.newTask,
  TaskStatus.processing,
  TaskStatus.compeletely,
];

typedef MenuEntry = DropdownMenuEntry<TaskStatus>;

Widget dropdownMenuStatus(Task task, BuildContext context) {
  final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
    list.map<MenuEntry>(
      (status) => MenuEntry(value: status, label: status.name),
    ),
  );

  return DropdownMenu<TaskStatus>(
    initialSelection: task.status,
    onSelected: (value) {
      if (value == null) return;

      task.status = value!;
      context.read<TaskCubit>().writeTasks();
    },
    dropdownMenuEntries: menuEntries,
  );
}
