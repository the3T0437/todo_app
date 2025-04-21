// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  ColorDropDown? colorDropDown;
  DateTime? deadLine = null;

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
      colorDropDown = ColorDropDown(color: colorLabel);
      deadLine = widget.task!.deadLineDate;
    } else {
      colorDropDown = ColorDropDown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();

    var children = [
      TextFormField(
        controller: titleControler,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "title",
        ),
        validator: (value) {
          if (value == null || value!.isEmpty) return "title can't be null";
          return null;
        },
      ),

      SizedBox(height: 10),
      TextFormField(
        controller: descriptionController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "description",
        ),
      ),
      SizedBox(height: 10),
      dropdownMenuTaskPriority(),
      SizedBox(height: 10),
      dropdownMenuTaskStatus(),
      SizedBox(height: 10),
      colorDropDown!,
      SizedBox(height: 10),
      Text("deadline: ${deadLine.toString()}"),
      SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () async {
          var pickDate = await showDatePicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2050),
            initialDate: deadLine ?? DateTime.now(),
          );

          setState(() => deadLine = pickDate);
        },
        icon: Icon(Icons.calendar_today),
        label: Text("pick deadline"),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          if (key.currentState!.validate()) {
            if (widget.task != null) {
              widget.task!.title = titleControler.text;
              widget.task!.description = descriptionController.text;
              widget.task!.priority = priority;
              widget.task!.status = status;
              widget.task!.color = colorDropDown!.color.color;
              widget.task!.colorName = colorDropDown!.color.name;
              widget.task!.deadLineDate = deadLine;
              widget.task!.editedDate = DateTime.now();

              widget.onSubmit(widget.task!);
            } else {
              var newTask = Task(
                title: titleControler.text,
                description: descriptionController.text,
                priority: priority,
                status: status,
                color: colorDropDown!.color.color,
                colorName: colorDropDown!.color.name,
                deadLineDate: deadLine,
                createDate: DateTime.now(),
                editedDate: DateTime.now(),
              );

              widget.onSubmit(newTask);
            }

            // context.read<TaskCubit>().addTask(
            //   Task(
            //     title: titleControler.text,
            //     description: descriptionController.text,
            //     priority: priority,
            //     status: status,
            //     color: colorDropDown.color.color,
            //     deadLineDate: deadLine,
            //     createDate: DateTime.now(),
            //     editedDate: DateTime.now(),
            //   ),
            // );
          }
        },
        child: Text(widget.submitButtonText),
      ),
    ];

    return Dialog(
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

  Widget dropdownMenuTaskPriority() {
    return DropdownButton<TaskPriority>(
      value: priority,
      onChanged: (newValue) {
        if (newValue == null) return;
        setState(() => priority = newValue);
      },
      items: taskPriorityMenuItems,
    );
  }

  Widget dropdownMenuTaskStatus() {
    return DropdownButton<TaskStatus>(
      value: status,
      onChanged: (newValue) {
        if (newValue == null) return;
        setState(() => status = newValue);
      },
      items: taskStatusMenuItems,
    );
  }
}
