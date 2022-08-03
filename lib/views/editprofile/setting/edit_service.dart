import 'package:flutter/material.dart';

class EditService extends StatefulWidget {
  EditService({Key? key}) : super(key: key);

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('เเก้ไขประเภทการให้บริการ'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
       body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
             Text('เลือกประเภทการให้บริการ'),
            ],
          ),
        ),
      ),
      );
  }
}