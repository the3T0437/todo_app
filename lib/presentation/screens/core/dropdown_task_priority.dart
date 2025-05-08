import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/bloc/task_state.dart';

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

final TaskPriorityColors = {
  TaskPriority.low: const Color.fromRGBO(64, 196, 255, 1),
  //TaskPriority.low: const Color.fromRGBO(33, 150, 243, 1),
  TaskPriority.medium: Color.fromARGB(255, 255, 193, 108),
  //TaskPriority.medium: Color.fromARGB(255, 255, 235, 59),
  TaskPriority.high: const Color.fromRGBO(255, 64, 129, 1),
};

final TaskPriorityNameColors = {
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

Widget DropdownMenuTaskPriority({
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
            TaskPriorityColors[initPriority] ?? Color.fromARGB(150, 59, 63, 65),
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        taskPriorityName[initPriority] ?? "Unknown",
        style: TextStyle(
          color:
              TaskPriorityNameColors[initPriority] ??
              Color.fromARGB(150, 59, 63, 65),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
