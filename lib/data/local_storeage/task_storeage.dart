import 'package:todoapp/domain/models/task.dart';

abstract class TaskStoreage {
  Future<void> writeTasks(List<Task> tasks);
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> removeTask(Task task);
}
