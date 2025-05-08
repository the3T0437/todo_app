import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:todoapp/domain/models/task.dart";
import "package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart";
import "package:todoapp/presentation/screen_tabbar/view_model/task_state.dart";
import "package:todoapp/presentation/screen_tabbar/widgets/card_task.dart";

/// A widget that displays a list of tasks with search functionality.
///
/// This widget is responsible for rendering a scrollable list of task cards
/// and includes a search bar for filtering tasks. It uses BLoC pattern for
/// state management and updates the UI based on the current [TaskState].
///
/// The widget takes a [displayTasks] function that determines which tasks to show
/// based on the current state, and a [searchController] for managing search input.

class ListTasks extends StatefulWidget {
  final List<Task> Function(TaskState) displayTasks;
  final TextEditingController searchController;

  ListTasks({
    super.key,
    required this.displayTasks,
    required this.searchController,
  });

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
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
      taskCards.add(CardTask(task: task));
    }

    taskCards.insert(0, searchBar);
    taskCards.add(SizedBox(height: 80));

    return taskCards;
  }

  Widget _getSearchBar(BuildContext context) {
    return Padding(
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
  }
}
