import 'package:flutter/material.dart';

// Normal, obscure özelliği olmayan/olmasına gerek olmayan textfield
class MyTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscuretext;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  const MyTextfield({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscuretext,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: Colors.grey.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.deepPurple.shade300,
              width: 1.5,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

// Şifre alanı - göz ikonu ile göster/gizle
class MytextfieldP extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  const MytextfieldP({super.key, this.controller, required this.hintText});

  @override
  State<MytextfieldP> createState() => _MytextfieldPState();
}

class _MytextfieldPState extends State<MytextfieldP> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.deepPurple.shade300,
              width: 1.5,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade600,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
