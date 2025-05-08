import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todoapp/domain/models/task.dart";
import "package:todoapp/presentation/bloc/task_cubit.dart";
import "package:todoapp/presentation/bloc/task_state.dart";
import "package:todoapp/presentation/screens/core/TaskCard.dart";

class TaskScreen extends StatefulWidget {
  final List<Task> Function(TaskState) displayTasks;

  TaskScreen({
    super.key,
    required this.displayTasks,
    required this.searchController,
  });
  final TextEditingController searchController;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final FocusNode searchFocus = FocusNode();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        List<Widget> taskCards = _getWidgetsInScreen(state, context);

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

  List<Widget> _getWidgetsInScreen(TaskState state, BuildContext context) {
    Widget searchBar = _getSearchBar(context);

    List<Widget> taskCards = [];
    var tasks = widget.displayTasks(state);
    for (Task task in tasks) {
      taskCards.add(TaskCard(task: task));
    }

    taskCards.insert(0, searchBar);
    taskCards.add(SizedBox(height: 80));

    return taskCards;
  }

  Widget _getSearchBar(BuildContext context) {
    var searchBar = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 10),
      child: SearchBar(
        onTapOutside: (event) => searchFocus.unfocus(),
        focusNode: searchFocus,
        elevation: WidgetStateProperty.fromMap({
          WidgetState.focused: 3,
          WidgetState.pressed: 3,
          WidgetState.any: 3,
        }),
        backgroundColor: WidgetStateColor.fromMap({
          WidgetState.focused: Colors.white,
          WidgetState.pressed: Colors.white,
          WidgetState.any: Colors.white,
        }),
        hintText: "Search",
        leading: const Icon(Icons.search),
        controller: widget.searchController,
        shape: WidgetStateOutlinedBorder.fromMap({
          WidgetState.any: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(width: 0.2, color: Colors.grey),
          ),
        }),
        hintStyle: WidgetStateProperty.fromMap({
          WidgetState.any: TextStyle(fontSize: 14, color: Colors.grey),
        }),
        onChanged:
            (value) => context.read<TaskCubit>().setSearchString(
              widget.searchController.text,
            ),
      ),
    );
    return searchBar;
  }
}
