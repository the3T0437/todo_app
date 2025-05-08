import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp/domain/models/task.dart';
import 'package:todoapp/presentation/bloc/task_cubit.dart';
import 'package:todoapp/presentation/bloc/task_state.dart';
import 'package:todoapp/presentation/screens/core/color.dart';
import 'package:todoapp/presentation/screens/core/dropdown_task_priority.dart';
import 'package:todoapp/presentation/screens/core/dropdown_task_status.dart';

class DialogTask extends StatefulWidget {
  final Task? task;
  final void Function(Task task) onSubmit;
  final String submitButtonText;

  const DialogTask({
    Key? key,
    this.task,
    required this.onSubmit,
    String? submitButtonText,
  }) : submitButtonText = submitButtonText ?? "Add New",
       super(key: key);

  @override
  State<StatefulWidget> createState() => _DialogTaskState();
}

class _DialogTaskState extends State<DialogTask> {
  var titleControler = TextEditingController();
  var descriptionController = TextEditingController();
  var priority = TaskPriority.low;
  var status = TaskStatus.newTask;
  ColorTable? colorTable;
  DateTime? deadLine = null;

  final titleFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleControler.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      priority = widget.task!.priority;
      status = widget.task!.status;

      var colorLabel = ColorLabel.values.firstWhere(
        (element) => element.name == widget.task!.colorName,
        orElse: () => ColorLabel.blue,
      );
      colorTable = ColorTable(color: colorLabel);
      deadLine = widget.task!.deadLineDate;
    } else {
      colorTable = ColorTable();
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    var children = [
      title(),
      SizedBox(height: 10),
      inputTitle(),
      SizedBox(height: 10),
      inputDescription(),
      SizedBox(height: 10),
      Row(
        children: [dropdownStatus(), SizedBox(width: 10), dropdownPriority()],
      ),
      SizedBox(height: 10),
      Text(
        "Color",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      colorTable!,
      SizedBox(height: 10),
      Row(
        children: [
          dateTimePicker(),
          SizedBox(width: 10),
          Expanded(child: buttonSubmit(key)),
        ],
      ),
    ];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      backgroundColor: Colors.white,
      child: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 160, 151, 141),
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: Text(
          widget.task != null ? "Update Task" : "Add New Task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget inputTitle() {
    return TextFormField(
      onTapOutside: (event) => titleFocusNode.unfocus(),
      focusNode: titleFocusNode,
      controller: titleControler,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: "Task Title",
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value!.isEmpty) return "title can't be null";
        return null;
      },
    );
  }

  Widget inputDescription() {
    return TextFormField(
      onTapOutside: (event) => descriptionFocusNode.unfocus(),
      focusNode: descriptionFocusNode,
      controller: descriptionController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        hintText: "Describe your task",
        hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      maxLines: 3,
      minLines: 1,
      textCapitalization: TextCapitalization.sentences,
    );
  }

  Widget dropdownStatus() {
    return DropdownMenuTaskStatus(
      onSelected: (taskStatus) {
        setState(() {
          status = taskStatus;
        });
      },
      initStatus: status,
    );
  }

  Widget dropdownPriority() {
    return DropdownMenuTaskPriority(
      onSelected:
          (priority) => setState(() {
            this.priority = priority;
          }),
      initPriority: priority,
    );
  }

  Widget dateTimePicker() {
    String deadLineStr = getDeadlineStr();
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed: () async {
        var pickDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
          initialDate: deadLine ?? DateTime.now(),
        );

        setState(() => deadLine = pickDate);
      },
      icon: Icon(Icons.calendar_today, size: 25),
      label: Text(deadLineStr),
    );
  }

  Widget buttonSubmit(GlobalKey<FormState> key) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      onPressed: () {
        if (key.currentState!.validate()) {
          if (widget.task != null) {
            widget.task!.title = titleControler.text;
            widget.task!.description = descriptionController.text;
            widget.task!.priority = priority;
            widget.task!.status = status;
            widget.task!.color = colorTable!.color.color;
            widget.task!.colorName = colorTable!.color.name;
            widget.task!.deadLineDate = deadLine;
            widget.task!.editedDate = DateTime.now();

            widget.onSubmit(widget.task!);
          } else {
            var newTask = Task(
              title: titleControler.text,
              description: descriptionController.text,
              priority: priority,
              status: status,
              color: colorTable!.color.color,
              colorName: colorTable!.color.name,
              deadLineDate: deadLine,
              createDate: DateTime.now(),
              editedDate: DateTime.now(),
            );

            widget.onSubmit(newTask);
          }

          Navigator.of(context).pop();
        }
      },
      child: Text(widget.submitButtonText),
    );
  }

  String getDeadlineStr() {
    var isVisiblityDeadline = deadLine != null;
    var deadLineStr = "";
    if (deadLine != null) {
      var deadline = deadLine!;
      deadLineStr =
          "${deadline.day.toString().padLeft(2, '0')}/${deadline.month.toString().padLeft(2, '0')}";
    } else
      deadLineStr = "Deadline";
    return deadLineStr;
  }
}
