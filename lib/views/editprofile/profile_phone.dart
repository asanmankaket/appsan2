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
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
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
            TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: const Color.fromARGB(255, 0, 142, 54),
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  sendDataProfile4(phone.text, context);
                },
                child: const Text(
                  'ยืนยัน',
                ))
          ],
        ),
      ),
    );
  }
}
