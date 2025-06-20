import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_state.dart';

final taskPriorityMenuItems =
    TaskPriority.values.map((status) {
      return DropdownMenuItem<TaskPriority>(
        value: status,
        child: Text(taskPriorityName[status] ?? "Unknown"),
      );
    }).toList();

// final TaskPriorityColors ={
//   TaskPriority.low: Color.fromARGB(255, 0, 255, 0),
//   TaskPriority.medium: Color.fromARGB(255, 255, 255, 0),
//   TaskPriority.high: Color.fromARGB(255, 255, 0, 0),
// }

final taskPriorityColors = {
  TaskPriority.low: const Color.fromRGBO(64, 196, 255, 1),
  //TaskPriority.low: const Color.fromRGBO(33, 150, 243, 1),
  TaskPriority.medium: Color.fromARGB(255, 255, 193, 108),
  //TaskPriority.medium: Color.fromARGB(255, 255, 235, 59),
  TaskPriority.high: const Color.fromRGBO(255, 64, 129, 1),
};

final taskPriorityNameColors = {
  TaskPriority.low: Colors.black,
  //TaskPriority.low: const Color.fromRGBO(33, 150, 243, 1),
  TaskPriority.medium: Colors.black,
  //TaskPriority.medium: Color.fromARGB(255, 255, 235, 59),
  TaskPriority.high: Colors.white,
};

final taskPriorityName = {
  TaskPriority.low: "Low",
  TaskPriority.medium: "Med",
  TaskPriority.high: "High",
};

/// A widget that displays a dropdown menu for task priority selection.
///
/// This widget creates a popup menu button that allows users to select task priorities
/// (Low, Medium, High). The selected priority is displayed in a container with
/// corresponding color coding and text styling.
///
/// The widget takes the following parameters:
/// * [onSelected] - Callback function called when a priority is selected
/// * [initPriority] - Initial priority value to display
/// * [onOpened] - Optional callback function called when the menu is opened
///
/// The widget uses predefined color schemes and text styles from [taskPriorityColors]
/// and [taskPriorityNameColors] to maintain consistent visual representation.

Widget dropdownMenuTaskPriority({
  required void Function(TaskPriority) onSelected,
  required TaskPriority initPriority,
  void Function()? onOpened,
}) {
  return PopupMenuButton<TaskPriority>(
    onSelected: onSelected,
    color: Colors.white,
    onOpened: onOpened,
    itemBuilder:
        (context) => [
          PopupMenuItem<TaskPriority>(
            value: TaskPriority.low,
            child: Text('Low'),
          ),
          PopupMenuItem<TaskPriority>(
            value: TaskPriority.medium,
            child: Text('Medium'),
          ),
          PopupMenuItem<TaskPriority>(
            value: TaskPriority.high,
            child: Text('High'),
          ),
        ],
    child: Container(
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   color:
        //       TaskPriorityColors[initPriority] ??
        //       Color.fromARGB(150, 59, 63, 65),
        //   width: 1,
        // ),
        color:
            taskPriorityColors[initPriority] ?? Color.fromARGB(150, 59, 63, 65),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        taskPriorityName[initPriority] ?? "Unknown",
        style: TextStyle(
          color:
              taskPriorityNameColors[initPriority] ??
              Color.fromARGB(150, 59, 63, 65),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
