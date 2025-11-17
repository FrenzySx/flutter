import 'package:flutter/material.dart';
import 'package:freestyle1/utilities/buttons.dart';

class DialogBox extends StatefulWidget {
  final TextEditingController controller;
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[400],
      elevation: 10,
      content: Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: [
            TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add A New Task ",
              ),
            ),
            Row(
              mainAxisAlignment: .end,
              children: [
                Buttons(text: "Save", onPressed: widget.onSave),
                const SizedBox(width: 50),
                Buttons(text: "Cancel", onPressed: widget.onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
