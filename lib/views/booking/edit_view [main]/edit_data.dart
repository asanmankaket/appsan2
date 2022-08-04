import 'package:flutter/material.dart';

class Editdata extends StatefulWidget {
  Editdata({Key? key}) : super(key: key);

  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('อัตราค่าบริการ/เเก้ไขข้อมูล'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
             Text('อัตราค่าบริการตามค่าเฉลี่ย'),
             SizedBox(height: 20,),
             Text('กำหนดค่าบริการ'),
             SizedBox(height: 20,),
             Text('กำหนดวันเวลาที่ให้บริการ'),
            ],
          ),
        ),
      ),
      );
  }
}