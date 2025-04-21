import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todoapp/domain/models/task.dart";
import "package:todoapp/presentation/bloc/task_cubit.dart";
import "package:todoapp/presentation/bloc/task_state.dart";
import "package:todoapp/presentation/screens/core/TaskCard.dart";

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
  }

  Widget body() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        var searchBar = Padding(
          padding: EdgeInsets.all(10),
          child: SearchBar(
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.focused: Colors.white,
              WidgetState.pressed: Colors.white,
              WidgetState.any: Colors.white,
            }),
            hintText: "Search",
            controller: searchController,
            onChanged:
                (value) => context.read<TaskCubit>().setSearchString(
                  searchController.text,
                ),
          ),
        );

        var tasks = displayTasks(state);
        List<Widget> taskCards = [];
        taskCards.add(searchBar);
        for (Task task in tasks) {
          taskCards.add(TaskCard(task: task));
        }
        return Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListView(children: taskCards),
              ),
            ),
          ],
        );
      },
    );
  }
}
