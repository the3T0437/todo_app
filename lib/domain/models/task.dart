// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

enum TaskStatus { newTask, processing, completed }

extension TaskStatusToJson on TaskStatus {
  String get toJson => name;
}

enum TaskPriority { low, medium, high }

extension TaskPriorityToJson on TaskPriority {
  String get toJson => name;
}

/// A model class representing a task in the application.
///
/// This class encapsulates all the properties and behaviors of a task,
/// including its title, description, status, priority, and various dates.
/// It provides methods for serialization and deserialization of task data.
///
/// Properties:
/// * [title] - The title of the task
/// * [description] - A detailed description of the task
/// * [status] - Current status of the task (new, processing, completed)
/// * [priority] - Priority level of the task (low, medium, high)
/// * [color] - Visual color representation of the task
/// * [colorName] - Name of the color for display purposes
/// * [createDate] - When the task was created
/// * [deadLineDate] - When the task is due
/// * [editedDate] - When the task was last modified
///
/// The class includes methods for converting to and from JSON format
/// for data persistence and transfer.

class Task {
  String title;
  String description;
  TaskStatus status;
  TaskPriority priority;
  Color color;
  String colorName;
  DateTime? createDate;
  DateTime? deadLineDate;
  DateTime? editedDate;

  Task({
    required this.title,
    this.description = "",
    this.priority = TaskPriority.low,
    this.color = Colors.blue,
    this.colorName = "blue",
    this.deadLineDate,
    this.status = TaskStatus.newTask,
    DateTime? createDate,
    DateTime? editedDate,
  }) : createDate = createDate ?? DateTime.now(),
       editedDate = editedDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'color': color.toARGB32(),
      'colorName': colorName,
      'status': status.name,
      'priority': priority.name,
      'createDate': createDate?.millisecondsSinceEpoch,
      'deadLineDate': deadLineDate?.millisecondsSinceEpoch,
      'editedDate': editedDate?.millisecondsSinceEpoch,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      color: Color(map['color'] as int),
      colorName: map['colorName'] ?? "Green" as String,
      createDate:
          map['createDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createDate'] as int)
              : null,
      status:
          map['status'] != null
              ? TaskStatus.values.firstWhere(
                (value) => value.name == map['status'],
                orElse: () => TaskStatus.newTask,
              )
              : TaskStatus.newTask,
      priority:
          map['priority'] != null
              ? TaskPriority.values.firstWhere(
                (value) => value.name == map['priority'],
              )
              : TaskPriority.low,
      deadLineDate:
          map['deadLineDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['deadLineDate'] as int)
              : null,
      editedDate:
          map['editedDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['editedDate'] as int)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);
}
