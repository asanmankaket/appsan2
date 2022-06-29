// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFormFieldModel extends StatelessWidget {
  const TextFormFieldModel({
    Key? key,
    @required this.labeltext,
    this.hintText,
    @required this.controller,
  }) : super(key: key);

  final String? labeltext;
  final String? hintText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 62, 144, 202)),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    );
  }
}

class TextFieldRegis extends StatelessWidget {
  const TextFieldRegis({
    Key? key,
    @required this.labeltext,
    @required this.controller,
    @required this.textEmpty,
  }) : super(key: key);
  final String? textEmpty;
  final String? labeltext;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return textEmpty;
        } else {
          return null;
        }
      },
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        helperText: textEmpty,
        hintText: labeltext,
        hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
