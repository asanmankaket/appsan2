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
    title.text = widget.data['title'];
    name.text = widget.data['fname'];
    surname.text = widget.data['lname'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
      ),
      body: SizedBox(
          child: Column(children: [
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: dropdownValue,
          items: items,
          onChanged: (value) {
            dropdownValue = value;
          },
        ),
        TextFormFieldModel2(
          controller: title,
          labelText: 'คำนำหน้า',
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
        TextButton(
            onPressed: () {
              sendDataProfile1(title.text, name.text, surname.text, context);
            },
            child: Text('ยืนยันการแก้ไข'))
      ])),
    );
  }
}
