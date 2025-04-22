import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/screens/core/dialog_Task.dart';
import 'package:todoapp/presentation/screens/core/dropdown_task_priority.dart';
import 'package:todoapp/presentation/screens/core/dropdown_task_status.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final Task task;

  @override
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isShowDesc = false;

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
          () => setState(() {
            isShowDesc = !isShowDesc;
          }),
      onDoubleTap:
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
        widget.task.description.trim() != "" &&
        isShowDesc;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              widget.task.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Visibility(
            visible: isVisibleDesc,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                DropdownMenuTaskStatus((TaskStatus status) {
                  widget.task.status = status;
                  context.read<TaskCubit>().writeTasks();
                }, widget.task.status),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(150, 59, 63, 65),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    taskPriorityName[widget.task.priority] ?? "Unknown",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isVisibleDeadline,
            child: Chip(
              avatar: Icon(Icons.calendar_month),
              label: Text(deadLineStr),
            ),
          ),
        ],
      ),
    );
  }
}
