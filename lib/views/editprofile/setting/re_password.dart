import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';

class Repassword extends StatefulWidget {
  const Repassword({Key? key}) : super(key: key);

  @override
  State<Repassword> createState() => _RepasswordState();
}

class _RepasswordState extends State<Repassword> {
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  dynamic data;
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getProfile(); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('เปลี่ยนรหัสผ่าน'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
        child: Column(
          children: [
            TextFormField(
              controller: oldpassword,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: newpassword,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: confirmpassword,
            ),
            TextButton(
                onPressed: () {
                  if (newpassword.text == confirmpassword.text) {
                    sendDataProfile1(
                        oldpassword.text, newpassword.text, context);
                  }
                },
                child: const Text('บันทึกข้อมูล'))
          ],
        ),
      ),
    );
  }
}
