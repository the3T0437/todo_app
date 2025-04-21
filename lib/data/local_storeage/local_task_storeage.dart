import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todoapp/data/local_storeage/task_storeage.dart';
import 'package:todoapp/domain/models/task.dart';

class LocalTaskStoreage extends TaskStoreage {
  @override
  Future<void> writeTasks(List<Task> tasks) async {
    var file = await _localFileTasks;
    await file.create(recursive: true, exclusive: false);
    file.writeAsStringSync(
      jsonEncode(tasks.map((task) => task.toMap()).toList()),
    );
  }

  @override
  Future<List<Task>> getTasks() async {
    try {
      var tasks = <Task>[];
      var file = await _localFileTasks;
      var tasksStr = file.readAsStringSync();
      if (tasksStr.isEmpty) return [];
      var tasksJson = json.decode(tasksStr) as List<dynamic>;
      tasksJson.forEach((element) => tasks.add(Task.fromMap(element)));

      return tasks;
    } on PathNotFoundException {
      return [];
    }
  }

  @override
  Future<void> addTask(Task task) async {
    var tasks = await getTasks();
    tasks.add(task);

    await writeTasks(tasks);
  }

  @override
  Future<void> removeTask(Task removeTask) async {
    var tasks = await getTasks();
    var index = tasks.indexWhere(
      (task) => task.toJson() == removeTask.toJson(),
    );
    tasks.removeAt(index);

    await writeTasks(tasks);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileTasks async {
    final directory = await _localPath;
    return File("$directory/data/tasks.json");
  }
}
