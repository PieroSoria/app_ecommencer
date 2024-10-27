import 'package:flutter/material.dart';

class InputCustom extends StatefulWidget {
  const InputCustom({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  State<InputCustom> createState() => _InputCustomState();
}

class _InputCustomState extends State<InputCustom> {
  final focusnode = FocusNode();
  @override
  void initState() {
    widget.controller.addListener(() {
      if (!focusnode.hasFocus) {
        focusnode.unfocus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        focusNode: focusnode,
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          label: Text(widget.title),
        ),
      ),
    );
  }
}
