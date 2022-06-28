import 'package:flutter/material.dart';

class TextFormFieldModel2 extends StatefulWidget {
  const TextFormFieldModel2({
    Key? key,
    @required this.labelText,
    this.hintText,
    @required this.controller,
    this.textError,
    this.helperText,
  }) : super(key: key);

  final String? labelText;
  final String? hintText;
  final String? textError;
  final String? helperText;
  final TextEditingController? controller;

  @override
  State<TextFormFieldModel2> createState() => _TextFormFieldModel2State();
}

class _TextFormFieldModel2State extends State<TextFormFieldModel2> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        if (value!.isEmpty) {
          return widget.textError;
        } else {
          return null;
        }
      },
      style: const TextStyle(
        color: Color.fromARGB(255, 28, 28, 28),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
