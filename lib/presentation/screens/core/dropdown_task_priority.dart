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
