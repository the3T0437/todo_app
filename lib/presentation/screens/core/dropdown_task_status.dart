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
