import 'package:flutter/material.dart';

Future<dynamic> showDeleteDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete"),
            ),
          ],
        ),
  );
}
