import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {super.key,
      this.label = "",
      required this.controller,
      required this.validator,
      this.obscureText = false});

  final String label;
  final TextEditingController controller;
  final String? Function(String) validator;
  final bool obscureText;
  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) => widget.validator(widget.controller.text),
        obscureText: widget.obscureText,
        enableSuggestions: !widget.obscureText,
        keyboardType: widget.obscureText
            ? TextInputType.visiblePassword
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
