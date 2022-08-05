import 'package:flutter/material.dart';
import '../../../configs/api.dart';

class Editdata extends StatefulWidget {
  const Editdata({Key? key}) : super(key: key);
  @override
  State<Editdata> createState() => _EditdataState();
}

class _EditdataState extends State<Editdata> {
  dynamic data;
  final TextEditingController _rateselect = TextEditingController();
  final TextEditingController _dateselcet = TextEditingController();
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    var item = await getAvg();
    setState(() {
      data = item;
    });
  }

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
              const SizedBox(height: 20),
              Text("ค่าแรงเฉลี่ยของแอพ : " + data[0]['RateAvg'] != null
                  ? data[0]['RateAvg'].toString()
                  : ""),
              const SizedBox(height: 10),
              Text("จำนวนพี่เลี้ยงที่ผ่านการสมัคร : " + data[0]['mentorpass'] !=
                      null
                  ? data[0]['mentorpass'].toString()
                  : ""),
              const SizedBox(height: 20),
              const Text('กำหนดค่าบริการ '),
              TextField(
                controller: _rateselect,
              ),
              const SizedBox(height: 20),
              const Text('กำหนดวันเวลาที่ให้บริการ....'),
              TextField(
                controller: _dateselcet,
              )
            ],
          ),
        ),
      ),
    );
  }
}
