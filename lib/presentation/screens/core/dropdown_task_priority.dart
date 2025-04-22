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

final taskPriorityName = {
  TaskPriority.low: "Low",
  TaskPriority.medium: "Medium",
  TaskPriority.high: "High",
};

Widget DropdownMenuTaskPriority(
  void Function(TaskPriority) onSelected,
  TaskPriority initPriority,
) {
  return PopupMenuButton<TaskPriority>(
    onSelected: onSelected,
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
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(150, 59, 63, 65),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        taskPriorityName[initPriority] ?? "Unknown",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
