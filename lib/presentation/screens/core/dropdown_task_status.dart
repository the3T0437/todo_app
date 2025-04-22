// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';

final taskStatusMenuItems =
    TaskStatus.values.map((status) {
      return DropdownMenuItem<TaskStatus>(
        value: status,
        child: Text(taskStatusName[status] ?? "Unknown"),
      );
    }).toList();

final taskStatusName = {
  TaskStatus.newTask: "New",
  TaskStatus.processing: "Processing",
  TaskStatus.compeletely: "Completed",
};

Widget DropdownMenuTaskStatus(
  void Function(TaskStatus) onSelected,
  TaskStatus initStatus,
) {
  return PopupMenuButton<TaskStatus>(
    onSelected: onSelected,
    itemBuilder:
        (context) => [
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.newTask,
            child: Text('New'),
          ),
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.processing,
            child: Text('In Process'),
          ),
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.compeletely,
            child: Text('Completed'),
          ),
        ],
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(150, 59, 63, 65),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        taskStatusName[initStatus] ?? "Unknown",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
