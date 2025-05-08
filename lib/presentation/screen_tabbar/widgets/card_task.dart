import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/screen_tabbar/view_model/task_cubit.dart';
import 'package:todoapp/presentation/widgets/dialog_task.dart';
import 'package:todoapp/presentation/widgets/dialog_delete.dart';
import 'package:todoapp/presentation/widgets/dropdown_task_priority.dart';
import 'package:todoapp/presentation/widgets/dropdown_task_status.dart';

class CardTask extends StatefulWidget {
  const CardTask({super.key, required this.task});
  final Task task;

  @override
  State<StatefulWidget> createState() => _CardTaskState();
}

class _CardTaskState extends State<CardTask> {
  bool isShowDesc = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _getTaskCard(),
      onLongPress: () => deleteDialog(),
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

  Widget _getTaskCard() {
    return Card(
      margin: EdgeInsets.only(bottom: 5, left: 16, right: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: EdgeInsets.all(10),
        color: widget.task.color,
        child: Column(
          children: [
            Row(children: [Expanded(child: _taskDetail())]),
            Row(children: [_deadline(), Spacer(), _taskStatus()]),
          ],
        ),
      ),
    );
  }

  Widget _taskDetail() {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [Expanded(child: _taskTitle())]),
          _description(),
        ],
      ),
    );
  }

  Widget _iconDelete() {
    return GestureDetector(
      onTap: () async {
        await deleteDialog();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.delete_outline_outlined, color: Colors.red),
      ),
    );
  }

  Future<void> deleteDialog() async {
    var isDelete = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Delete Task"),
            content: Text("Are you sure you want to delete this task?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Delete"),
              ),
            ],
          ),
    );

    if (isDelete == true) {
      context.read<TaskCubit>().removeTask(widget.task);
    }
  }

  Widget _description() {
    //return Visibility(visible: _isVisibleDesc(), child: _taskDescription());
    return AnimatedSize(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      child: _isVisibleDesc() ? _taskDescription() : SizedBox.shrink(),
    );
  }

  Widget _deadline() {
    return Visibility(
      visible: _isHaveDeadline(),
      child: _taskDeadline(_getDeadlineStr()),
    );
  }

  bool _isHaveDeadline() {
    return widget.task.deadLineDate != null;
  }

  bool _isVisibleDesc() {
    return widget.task.description.isNotEmpty &&
        widget.task.description.trim() != "" &&
        isShowDesc;
  }

  String _getDeadlineStr() {
    var deadLineStr = "";
    if (_isHaveDeadline()) {
      var deadline = widget.task.deadLineDate!;
      deadLineStr =
          "${deadline.day.toString().padLeft(2, '0')}/${deadline.month.toString().padLeft(2, '0')}/${deadline.year}";
    }
    return deadLineStr;
  }

  Widget _taskTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        widget.task.title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _taskDescription() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        widget.task.description,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
    );
  }

  Widget _taskStatus() {
    var indexOfTaskPriority = widget.task.priority.index;
    final opacity = 150 + (indexOfTaskPriority * 50);

    return Row(
      children: [
        dropdownMenuTaskStatus(
          onSelected: (TaskStatus status) {
            widget.task.status = status;
            context.read<TaskCubit>().writeTasks();
          },
          initStatus: widget.task.status,
          onOpened: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        // SizedBox(width: 10),
        // DropdownMenuTaskPriority(
        //   onSelected: (TaskPriority priority) {
        //     widget.task.priority = priority;
        //     context.read<TaskCubit>().writeTasks();
        //   },
        //   initPriority: widget.task.priority,
        //   onOpened: () {
        //     FocusManager.instance.primaryFocus?.unfocus();
        //   },
        // ),
      ],
    );
  }

  Widget _taskDeadline(String deadLineStr) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 25,
            color: Color.fromARGB(150, 0, 0, 0),
          ),
          SizedBox(width: 10),
          Text(
            deadLineStr,
            style: TextStyle(color: Color.fromARGB(150, 0, 0, 0)),
          ),
        ],
      ),
    );

    // return Chip(
    //   avatar: Icon(Icons.calendar_month, size: 25),
    //   label: Text(deadLineStr),
    // );
  }
}
