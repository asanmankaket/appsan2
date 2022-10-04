// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:creative/configs/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Editdata extends StatefulWidget {
  const Editdata({Key? key}) : super(key: key);

  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  dynamic data, data2;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item2 = await getProfile();
    dynamic item = await getAvg();
    setState(() {
      data = item;
      data2 = item2;
    });
  }

  TextEditingController rate = TextEditingController();

  late int _currentIntValue = data[0]['RateAvg'].toInt();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 212, 212, 212),
      appBar: AppBar(
        title: const Text('อัตราค่าบริการ/เเก้ไขข้อมูล'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: data != null
          ? (Container(
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
                          Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text('${data2['men_rate']} บาท/ชั่วโมง',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                SizedBox(height: 20),
                                Divider(
                                  color: Colors.black,
                                  thickness: 3,
                                ),
                                SizedBox(height: 20),
                                Text('อัตราค่าบริการที่ตั้งไว้',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
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
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Color.fromARGB(255, 241, 196, 253),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 300,
                        ),
                        Text('อัตราค่าบริการเฉลี่ยของทั้งแอพประมาณ :'),
                        Text(
                          '${data[0]['RateAvg']} บาท/ชั่วโมง',
                          style: TextStyle(
                              color: Color.fromARGB(255, 64, 0, 255),
                              fontSize: 20),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  NumberPicker(
                    axis: Axis.horizontal,
                    value: _currentIntValue,
                    minValue: 0,
                    maxValue: 100,
                    step: 1,
                    onChanged: (value) =>
                        setState(() => _currentIntValue = value),
                  ),
                  Text('Current value:' + _currentIntValue.toString()),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      sendDataProfileWorkRate(_currentIntValue, context);
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      primary: Colors.purple,
                    ),
                  )
                ],
              ),
            ))
          : SizedBox(
              child: Center(
                child: CupertinoActivityIndicator(),
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