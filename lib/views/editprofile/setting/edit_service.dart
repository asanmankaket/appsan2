import 'package:creative/configs/api.dart';
import 'package:creative/models/charofname.dart';
import 'package:flutter/material.dart';

class EditService extends StatefulWidget {
  const EditService({Key? key}) : super(key: key);

  @override
  State<EditService> createState() => _EditServiceState();
}

String? dropdownValue;
List<DropdownMenuItem<String>>? items = [
  const DropdownMenuItem(
    value: '0',
    child: Text(
      'ดูแลเด็ก',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
  const DropdownMenuItem(
    value: '1',
    child: Text(
      'ดูแลผู้ป่วย',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
  const DropdownMenuItem(
    value: '2',
    child: Text(
      'ดูแลผู้สูงอายุ',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
];

class _EditServiceState extends State<EditService> {
  String revestWork = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('เเก้ไขประเภทการให้บริการ'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'ประเภทการให้บริการ',
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
                value: dropdownValue,
                items: items,
                onChanged: (value) {
                  dropdownValue = value;
                },
              ),
              TextButton(
                  onPressed: () {
                    revestWork = typeWorkRevers(dropdownValue!);
                    sendDataProfile7(revestWork, context);
                  },
                  child: const Text('ยืนยันการแก้ไข'))
            ],
          ),
        ),
      ),
    );
  }
}
