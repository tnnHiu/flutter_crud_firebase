import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool typeText;
  final TextEditingController controller;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.typeText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: typeText ? TextInputType.text : TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan.shade700),
            borderRadius: BorderRadius.circular(8),
          ),
          fillColor: Colors.cyan.shade600,
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
