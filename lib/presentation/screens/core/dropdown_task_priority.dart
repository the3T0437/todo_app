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
  TaskPriority.medium: const Color.fromRGBO(255, 215, 64, 1),
  TaskPriority.high: const Color.fromRGBO(255, 64, 129, 1),
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:
            TaskPriorityColors[initPriority] ?? Color.fromARGB(150, 59, 63, 65),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        taskPriorityName[initPriority] ?? "Unknown",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
