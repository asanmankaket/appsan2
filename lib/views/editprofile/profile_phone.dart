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
    phone.text = widget.data['men_phone'];
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
            const SizedBox(height: 20),
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'เบอร์โทรศัพท์'),
                controller: phone,
                maxLength: 10,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendDataProfile4(phone.text, context);
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                primary: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
