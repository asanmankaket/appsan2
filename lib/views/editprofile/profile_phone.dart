// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../../configs/api.dart';

class ProfilePhone extends StatefulWidget {
  const ProfilePhone({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<ProfilePhone> createState() => _ProfilePhoneState();
}

class _ProfilePhoneState extends State<ProfilePhone> {
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    phone.text = widget.data['phone'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขเบอร์โทรศัพท์'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: phone,
              maxLength: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                 sendDataProfile4(phone.text, context);
              },
              child: Wrap(
                children: <Widget>[
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("บันทึก",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                primary: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
