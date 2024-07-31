import 'package:flutter/material.dart';

class Addtodo extends StatefulWidget {
  void Function(String addData) changeText;
  Addtodo({super.key, required this.changeText});

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController todoText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Enter you Todo Task Here"),
        ),
        TextField(
          controller: todoText,
          decoration: InputDecoration(
              hintText: "Enter Task", labelText: "Enter the Task"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                widget.changeText(todoText.text);
                todoText.text = '';
              },
              child: Text("Submit")),
        )
      ],
    );
  }
}
