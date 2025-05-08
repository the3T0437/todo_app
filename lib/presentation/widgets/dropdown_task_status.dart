// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart';

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
  TaskStatus.completed: "Completed",
};

final taskStatusColors = {
  TaskStatus.newTask: Colors.green,
  TaskStatus.processing: Colors.blue,
  TaskStatus.completed: Colors.yellow,
};

final taskStatusTextColors = {
  TaskStatus.newTask: Colors.white,
  TaskStatus.processing: Colors.white,
  TaskStatus.completed: Colors.black,
};

Widget dropdownMenuTaskStatus({
  required void Function(TaskStatus) onSelected,
  void Function()? onOpened,
  required TaskStatus initStatus,
}) {
  return PopupMenuButton<TaskStatus>(
    onSelected: onSelected,
    onOpened: onOpened,
    color: Colors.white,
    itemBuilder:
        (context) => [
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.newTask,
            child: Text('New'),
          ),
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.processing,
            child: Text('Processing'),
          ),
          PopupMenuItem<TaskStatus>(
            value: TaskStatus.completed,
            child: Text('Completed'),
          ),
        ],
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   color:
        //       taskStatusColors[initStatus] ?? Color.fromARGB(150, 59, 63, 65),
        //   style: BorderStyle.solid,
        // ),
        color: taskStatusColors[initStatus] ?? Color.fromARGB(150, 59, 63, 65),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        taskStatusName[initStatus] ?? "Unknown",
        style: TextStyle(
          color: taskStatusTextColors[initStatus] ?? Colors.white,
          fontWeight: FontWeight.bold,
        ),
        // style: TextStyle(
        //   color:
        //       taskStatusColors[initStatus] ?? Color.fromARGB(150, 59, 63, 65),
        //   fontWeight: FontWeight.bold,
        // ),
      ),
    ),
  );
}
