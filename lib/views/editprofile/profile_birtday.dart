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
    widget.data != null
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
        actions: [
          IconButton(
              onPressed: () {
                sendDataProfile6(picdate.text, context);
                print(picdate.text);
              },
              icon: const Icon(Icons.check_outlined))
        ],
      ),
      body: Column(
        children: [
          Text('แก้วันที่'),
          Text(picdate.text),
          TextButton(onPressed: picdateTime, child: Text('แก้ไข'))
        ],
      ),
    );
  }
}
