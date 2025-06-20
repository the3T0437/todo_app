// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todoapp/domain/models/task.dart';

/// A state class for managing the task list and search functionality.
///
/// This class is responsible for managing the task list and search functionality.
/// It uses BLoC pattern for state management and updates the UI based on the current [TaskState].
///
/// The widget takes a [tasks] parameter to display the task details.

class TaskState {
  List<Task> tasks;
  String? searchStr;
  List<Task> get newTasks {
    searchStr = searchStr?.toLowerCase();
    var newTasks =
        tasks.where((task) => task.status == TaskStatus.newTask).toList();
    var searchTasks =
        newTasks
            .where(
              (task) =>
                  task.title.toLowerCase().contains(searchStr ?? "") ||
                  task.description.toLowerCase().contains(searchStr ?? ""),
            )
            .toList();

    searchTasks.sort(
      (task1, task2) => task2.priority.index.compareTo(task1.priority.index),
    );

    return searchTasks;
  }

  List<Task> get processingTasks {
    searchStr = searchStr?.toLowerCase();
    var processingTasks =
        tasks.where((task) => task.status == TaskStatus.processing).toList();

    var searchTasks =
        processingTasks
            .where(
              (task) =>
                  task.title.toLowerCase().contains(searchStr ?? "") ||
                  task.description.toLowerCase().contains(searchStr ?? ""),
            )
            .toList();

    searchTasks.sort(
      (task1, task2) => task2.priority.index.compareTo(task1.priority.index),
    );

    return searchTasks;
  }

  List<Task> get completely {
    searchStr = searchStr?.toLowerCase();
    var newTasks =
        tasks.where((task) => task.status == TaskStatus.completed).toList();

    var searchTasks =
        newTasks
            .where(
              (task) =>
                  task.title.toLowerCase().contains(searchStr ?? "") ||
                  task.description.toLowerCase().contains(searchStr ?? ""),
            )
            .toList();

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
