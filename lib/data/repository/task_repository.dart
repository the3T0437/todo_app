// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:todoapp/data/local_storeage/task_storeage.dart';
import 'package:todoapp/domain/models/task.dart';

abstract class TaskRepository {
  Future<void> writeTasks(List<Task> tasks);
  Future<List<Task>> getTasks();
  Future<List<Task>> addTask(Task task);
  Future<List<Task>> removeTask(Task task);
}

class TaskRepositoryImp implements TaskRepository {
  TaskStoreage store;

  TaskRepositoryImp({required this.store});

  @override
  Future<List<Task>> addTask(Task task) async {
    await store.addTask(task);
    return store.getTasks();
  }

  @override
  Future<List<Task>> getTasks() {
    return store.getTasks();
  }

  @override
  Future<List<Task>> removeTask(Task task) async {
    await store.removeTask(task);
    return store.getTasks();
  }

  @override
  Future<void> writeTasks(List<Task> tasks) {
    return store.writeTasks(tasks);
  }
}
