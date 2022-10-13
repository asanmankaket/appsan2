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
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
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
                  decoration: InputDecoration(
                    icon: const Icon(Icons.cake),
                    filled: true,
                    fillColor: Colors.purple.shade100,
                    hintStyle: const TextStyle(color: Colors.purple),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2),
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
                    children: <Widget>[
                      const Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("บันทึก",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius:  BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    primary: Colors.purple,
                  ),
                )
              : const Text(""),
        ],
      ),
    );
  }
}
