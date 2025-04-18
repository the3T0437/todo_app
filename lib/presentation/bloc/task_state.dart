// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todoapp/domain/models/task.dart';

class TaskState {
  List<Task> tasks;
  String? searchStr;
  List<Task> get newTasks {
    var newTasks =
        tasks.where((task) => task.status == TaskStatus.newTask).toList();
    var searchTasks =
        newTasks.where((task) => task.title.contains(searchStr ?? "")).toList();

    searchTasks.sort(
      (task1, task2) => task2.priority.index.compareTo(task1.priority.index),
    );

    return searchTasks;
  }

  List<Task> get processingTasks {
    var processingTasks =
        tasks.where((task) => task.status == TaskStatus.processing).toList();

    var searchTasks =
        processingTasks
            .where((task) => task.title.contains(searchStr ?? ""))
            .toList();

    searchTasks.sort(
      (task1, task2) => task2.priority.index.compareTo(task1.priority.index),
    );

    return searchTasks;
  }

  List<Task> get completely {
    var newTasks =
        tasks.where((task) => task.status == TaskStatus.compeletely).toList();

    var searchTasks =
        newTasks.where((task) => task.title.contains(searchStr ?? "")).toList();

    searchTasks.sort(
      (task1, task2) => task2.priority.index.compareTo(task1.priority.index),
    );

    return searchTasks;
  }

  TaskState(this.tasks, {this.searchStr});

  TaskState copyWith({List<Task>? tasks, String? searchStr}) {
    return TaskState(
      tasks ?? this.tasks,
      searchStr: searchStr ?? this.searchStr,
    );
  }
}
