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
      print(data);
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
              Text('อัตราค่าบริการตามค่าเฉลี่ย : ${data[0]['RateAvg']}'),
              const SizedBox(height: 20),
              const Text('กำหนดค่าบริการ'),
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
