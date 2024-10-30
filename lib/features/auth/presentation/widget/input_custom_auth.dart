import 'package:flutter/material.dart';

class InputCustomAuth extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final bool isPassword;
  final Widget? icons;
  const InputCustomAuth({
    super.key,
    required this.controller,
    required this.title,
    this.isPassword = false,
    this.icons,
  });

  @override
  State<InputCustomAuth> createState() => _InputCustomAuthState();
}

class _InputCustomAuthState extends State<InputCustomAuth> {
  bool oscureText = false;

  @override
  void initState() {
    oscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: oscureText,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          labelText: widget.title,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            color: Color.fromARGB(255, 214, 14, 0),
            fontSize: 20,
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      oscureText = !oscureText;
                    });
                  },
                  child: oscureText
                      ? const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                )
              : widget.icons,
        ),
      ),
    );
  }
}
