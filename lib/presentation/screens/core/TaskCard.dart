import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/screens/core/dialog_Task.dart';
import 'package:todoapp/presentation/screens/core/dropdown_task_status.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final Task task;

  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 10,
        child: IntrinsicHeight(
          child: Row(children: [taskColor(), taskDetail()]),
        ),
      ),
      onTap:
          () => showDialog(
            context: context,
            builder:
                (contextBuilder) => DialogTask(
                  task: widget.task,
                  onSubmit: (task) => context.read<TaskCubit>().writeTasks(),
                  submitButtonText: "Update",
                ),
          ),
    );
  }

  Widget taskColor() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 10,
      color: widget.task.color,
    );
  }

  Column taskDetail() {
    var isVisiblityDeadline = widget.task.deadLineDate != null;
    return Column(
      children: [
        Text(widget.task.title),
        Text(widget.task.description),
        DropdownMenuTaskStatus(),
        Visibility(
          child: Text(widget.task.deadLineDate.toString()),
          visible: isVisiblityDeadline,
        ),
      ],
    );
  }

  Widget DropdownMenuTaskStatus() {
    return DropdownButton<TaskStatus>(
      value: widget.task.status,
      onChanged: (newValue) {
        if (newValue == null) return;
        widget.task.status = newValue;

        context.read<TaskCubit>().writeTasks();
      },
      items: taskStatusMenuItems,
    );
  }
}
