import 'package:flutter/material.dart';

/// A dialog widget for confirming task deletion.
///
/// This widget displays a confirmation dialog when a user attempts to delete a task.
/// It provides options to either confirm or cancel the deletion.
///
/// The dialog includes:
/// * A title indicating the deletion action
/// * A confirmation message
/// * Cancel and Delete buttons
///
/// Returns a Future<bool> that resolves to:
/// * true if the user confirms deletion
/// * false if the user cancels

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
