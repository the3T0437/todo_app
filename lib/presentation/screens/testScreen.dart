import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Screen')),
      body: PopupMenuButton<String>(
        onSelected: (String value) {
          print('Selected: $value');
        },
        itemBuilder:
            (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(value: 'Option 1', child: Text('Option 1')),
              PopupMenuItem<String>(value: 'Option 2', child: Text('Option 2')),
              PopupMenuItem<String>(value: 'Option 3', child: Text('Option 3')),
            ],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.amber,
          ),
          padding: EdgeInsets.all(10),
          child: Text("Show Dropdown"),
        ),
      ),
    );
  }
}
