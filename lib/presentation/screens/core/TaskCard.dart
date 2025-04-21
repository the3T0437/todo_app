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
      child: Dismissible(
        key: Key(widget.task.toJson()),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.delete, color: Colors.white, size: 30),
        ),
        onDismissed: (direction) {
          context.read<TaskCubit>().removeTask(widget.task);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: widget.task.color,
                    child: taskDetail(),
                  ),
                ),
              ],
            ),
          ),
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

  Widget taskDetail() {
    var isVisibleDeadline = widget.task.deadLineDate != null;
    var deadLineStr = "";
    if (isVisibleDeadline) {
      var deadline = widget.task.deadLineDate!;
      deadLineStr =
          "${deadline.day.toString().padLeft(2, '0')}/${deadline.month.toString().padLeft(2, '0')}/${deadline.year}";
    }

    var isVisibleDesc =
        widget.task.description.isNotEmpty &&
        widget.task.description.trim() != "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.task.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Visibility(
          visible: isVisibleDesc,
          child: Text(
            widget.task.description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
        ),
        DropdownMenuTaskStatus(),
        Visibility(child: Text(deadLineStr), visible: isVisibleDeadline),
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
