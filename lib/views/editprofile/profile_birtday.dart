import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileBirtday extends StatefulWidget {
  const ProfileBirtday({
    Key? key,
    required this.data,
  }) : super(key: key);
  final dynamic data;
  @override
  State<ProfileBirtday> createState() => _ProfileBirtdayState();
}

class _ProfileBirtdayState extends State<ProfileBirtday> {
  TextEditingController picdate = TextEditingController();
  @override
  void initState() {
    super.initState();
    widget.data['men_birtday'] != null
        ? picdate.text = DateFormat("yyyy-MM-dd")
            .format(DateTime.parse(widget.data['men_birtday']))
        : picdate.text = "";
  }

  DateTime? datenow = DateTime.now();

  void picdateTime() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year - 11, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year - 10, DateTime.now().day));

    if (date != null) {
      setState(() {
        datenow = date;
        picdate.text = DateFormat("yyyy-MM-dd").format(date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('วันเดือนปีเกิด'),
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: SizedBox(
              width: 300,
              child: TextField(
                  readOnly: true,
                  onTap: picdateTime,
                  controller: picdate,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.cake),
                    filled: true,
                    fillColor: Color.fromARGB(255, 184, 191, 198),
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 76, 124, 172),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 124, 172),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 76, 124, 172), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    //     )),
                  )),
            ),
          ),
          // Text(picdate.text),
          // TextButton(onPressed: picdateTime, child: Text('แก้ไข'))
          const SizedBox(height: 30),
          picdate.text !=
                  DateFormat("yyyy-MM-dd")
                      .format(DateTime.parse(widget.data['men_birtday']))
              ? ElevatedButton(
                  onPressed: () {
                    sendDataProfile6(picdate.text, context);
                  },
                  child: Wrap(
                    children: const <Widget>[
                      Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      SizedBox(width: 10),
                      Text("บันทึก",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                    primary: const Color.fromARGB(255, 76, 124, 172),
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }
}
