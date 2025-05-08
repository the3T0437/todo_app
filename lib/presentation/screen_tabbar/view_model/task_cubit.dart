import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/data/repository/task_repository.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskRepository repository;

  TaskCubit(this.repository) : super(TaskState([]));

  void getTasks() {
    repository.getTasks().then((tasks) => emit(state.copyWith(tasks: tasks)));
  }

  void removeTask(Task task) {
    repository.removeTask(task).then((tasks) => getTasks());
  }

  void addTask(Task task) {
    repository.addTask(task).then((tasks) => getTasks());
  }

  void writeTasks() {
    repository.writeTasks(state.tasks).then((value) => getTasks());
  }

  void setSearchString(String search) {
    state.searchStr = search;
    emit(TaskState(state.tasks, searchStr: search));
  }
}
