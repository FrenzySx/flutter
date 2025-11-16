import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final VoidCallback onTap;

  const MyButton({super.key, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25),
        child: const Center(child: Text('Tap')),
      ),
    );
  }
}
