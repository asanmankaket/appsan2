// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../configs/api.dart';
import '../../models/textformfieldmodel2.dart';

class ProfileName extends StatefulWidget {
  const ProfileName({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<ProfileName> createState() => _ProfileNameState();
}

String? dropdownValue;
List<DropdownMenuItem<String>>? items = [
  const DropdownMenuItem(
    value: 'นาย',
    child: Text(
      'นาย',
    ),
  ),
  const DropdownMenuItem(
    value: 'นาง',
    child: Text(
      'นาง',
    ),
  ),
  const DropdownMenuItem(
    value: 'นางสาว',
    child: Text(
      'นางสาว',
    ),
  ),
];

class _ProfileNameState extends State<ProfileName> {
  TextEditingController title = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.data['title'];
    name.text = widget.data['fname'];
    surname.text = widget.data['lname'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เเก้ไขชื่อผู้ใช้'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
            child: Column(children: [
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'คำนำหน้า',
              labelStyle: const TextStyle(color: Colors.black),
              hintStyle: const TextStyle(color: Colors.black),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
                borderRadius: BorderRadius.all(
                  const Radius.circular(50),
                ),
              ),
            ),
            value: dropdownValue,
            items: items,
            onChanged: (value) {
              dropdownValue = value;
            },
          ),
          const SizedBox(height: 15),
          TextFormFieldModel2(
            labelText: 'ชื่อ',
            controller: name,
          ),
          const SizedBox(height: 15),
          TextFormFieldModel2(
            labelText: 'นามสกุล',
            controller: surname,
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              sendDataProfile1(
                  dropdownValue!, name.text, surname.text, context);
              print(dropdownValue);
            },
            child: Wrap(
              children: <Widget>[
                Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 24.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("บันทึก",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.symmetric(horizontal: 20),
              primary: Colors.purple,
            ),
          ),

          // TextButton(
        ])),
      ),
    );
  }
}
