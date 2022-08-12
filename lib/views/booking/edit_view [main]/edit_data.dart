// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Editdata extends StatefulWidget {
  Editdata({Key? key}) : super(key: key);

  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  TextEditingController rate = TextEditingController();
  late int _currentIntValue = 32;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 212, 212),
      appBar: AppBar(
        title: const Text('อัตราค่าบริการ/เเก้ไขข้อมูล'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Form(
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                            height: 180.0,
                            width: 370.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 160, 42, 207),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(4, 5), // Shadow position
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Text('NULL',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text('______________________________',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(
                                height: 30,
                              ),
                              Text('อัตราค่าบริการตามค่าเฉลี่ย',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('กำหนดค่าบริการ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                readOnly: true,
                controller: rate,
                onTap: (() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('ค่าแรงต่อชั่วโมงโดยเฉลี่ย'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('32 บาทต่อชั่วโมง'),
                                NumberPicker(
                                  value: _currentIntValue,
                                  minValue: 0,
                                  maxValue: 100,
                                  step: 1,
                                  haptics: true,
                                  onChanged: (value) => setState(() {
                                    _currentIntValue = value;
                                  }),
                                ),
                                Text('Current value:' +
                                    _currentIntValue.toString()),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context,
                                          rate.text =
                                              _currentIntValue.toString());
                                    },
                                    child: const Text('ยืนยัน'))
                              ],
                            ),
                          ));
                }),
                decoration: const InputDecoration(
                  labelText: 'ค่าแรงต่อชั่วโมง',
                  helperText: 'Tyep you password more 6 Charactor',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 255, 255), width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Center(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text('NULL',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue)),
//               SizedBox(
//                 height: 15,
//               ),
//               Text('อัตราค่าบริการตามค่าเฉลี่ย',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               Text('กำหนดค่าบริการ'),
//               SizedBox(
//                 height: 20,
//               ),
//               Text('กำหนดวันเวลาที่ให้บริการ....'),
//             ],
//           ),
//         ),
//       ),
