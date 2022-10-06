import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';

class EditService extends StatefulWidget {
  const EditService({Key? key, this.data}) : super(key: key);
  final dynamic data;
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
      'ดูแลผู้สูงอายุ',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
  const DropdownMenuItem(
    value: '2',
    child: Text(
      'ดูแลผู้ป่วย',
      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
    ),
  ),
];

class _EditServiceState extends State<EditService> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      dropdownValue = widget.data;
    }
  }

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
              const SizedBox(
                height: 40,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'ประเภทการให้บริการ',
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 100, 100, 100)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                value: dropdownValue,
                items: items,
                onChanged: (value) {
                  setState(() {
                    dropdownValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  sendDataProfile7(dropdownValue, context);
                },
                child: Wrap(
                  children: const <Widget>[
                    Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("บันทึก",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  primary: Colors.purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
