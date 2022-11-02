// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:creative/configs/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

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
      appBar: AppBar(
        elevation: 0,
        title: const Text('อัตราค่าบริการ/เเก้ไขข้อมูล'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.1, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Color.fromARGB(255, 76, 124, 172),
                  // Color.fromARGB(255, 240, 240, 240)
                  Colors.deepPurple,
                  Colors.white
                ])),
        child: data != null
            ? SingleChildScrollView(
                child: (Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Text('${data2['men_rate']} บาท/ชั่วโมง',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(height: 20),
                              Divider(
                                color: Colors.deepPurple,
                                thickness: 3,
                              ),
                              SizedBox(height: 10),
                              Text('อัตราค่าบริการที่ตั้งไว้',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('กำหนดค่าบริการ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple,
                              blurRadius: 6,
                              offset: Offset(4, 5), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(children: [
                          Text('อัตราค่าบริการเฉลี่ยของทั้งแอปประมาณ :'),
                          Text(
                            '${data[0]['RateAvg']} บาท/ชั่วโมง',
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 20),
                          ),
                          SizedBox(height: 40),
                          SpinBox(
                            max: 300,
                            min: 1,
                            value: data[0]['RateAvg'],
                            onChanged: (value) {
                              _currentIntValue = value.toInt();
                            },
                          ),
                          // NumberPicker(
                          //   axis: Axis.horizontal,
                          //   value: _currentIntValue,
                          //   minValue: 0,
                          //   maxValue: 100,
                          //   step: 1,
                          //   onChanged: (value) =>
                          //       setState(() => _currentIntValue = value),
                          // ),
                          // SizedBox(height: 10),
                          // Text('อัตราค่าบริการที่เลือก:' +
                          //     _currentIntValue.toString()),
                        ]),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          sendDataProfileWorkRate(_currentIntValue, context);
                        },
                        child: Wrap(
                          children: const <Widget>[
                            Icon(
                              Icons.save,
                              color: Colors.deepPurple,
                              size: 24.0,
                            ),
                            SizedBox(width: 10),
                            Text("บันทึก",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                )),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            primary: Colors.white),
                      )
                    ],
                  ),
                )),
              )
            : SizedBox(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
      ),
    );
  }
}
