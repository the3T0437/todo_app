import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/data/local_store/local_task_store.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/presentation/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  portraitMode();

  var taskStore = LocalTaskStore();
  final TaskRepository taskRepository = TaskRepositoryImp(store: taskStore);
  runApp(MyApp(repository: taskRepository));
}

void portraitMode() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
