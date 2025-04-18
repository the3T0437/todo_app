import 'package:flutter/material.dart';
import 'package:todoapp/data/local_storeage/local_task_storeage.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/app.dart';

void main() {
  var taskStore = LocalTaskStoreage();
  final TaskRepository taskRepository = TaskRepositoryImp(store: taskStore);
  runApp(MyApp(repository: taskRepository));
}
