// ignore_for_file: prefer_const_constructors

import 'package:creative/models/charofname.dart';
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
  const TextFieldRegis(
      {Key? key,
      @required this.labeltext,
      @required this.controller,
      @required this.textEmpty,
      this.keytype,
      this.checkCiz,
      this.maxlength})
      : super(key: key);
  final String? textEmpty;
  final String? labeltext;
  final bool? keytype;
  final TextEditingController? controller;
  final int? maxlength;
  final bool? checkCiz;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keytype != true ? null : TextInputType.number,
      maxLength: maxlength,
      controller: controller,
      validator: (value) {
        if (checkCiz == true) {
          if (checkIdCard(value) == false) {
            return "รหัสบัตรประชาชนไม่ถูกต้อง";
          }
        }
        if (value!.isEmpty) {
          return textEmpty;
        } else {
          return null;
        }
      },
      style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: labeltext,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
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
    return Column(
      children: [
        TextFormField(
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
                Radius.circular(10),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class TextRepassword extends StatelessWidget {
  const TextRepassword(
      {Key? key,
      @required this.controller,
      @required this.hintText,
      @required this.labeltext})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final String? labeltext;
  @override
  Widget build(BuildContext context) {
    bool hidepassword = true;
    return TextField(
        controller: controller,
        obscureText: hidepassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 184, 191, 198),
          labelText: labeltext,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 76, 124, 172),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 76, 124, 172),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 76, 124, 172), width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ));
  }
}
