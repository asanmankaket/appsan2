import 'package:flutter/material.dart';

class Repassword extends StatefulWidget {
  Repassword({Key? key}) : super(key: key);

  @override
  State<Repassword> createState() => _RepasswordState();
}

class _RepasswordState extends State<Repassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('เปลี่ยนรหัสผ่าน'),
        backgroundColor: Color.fromARGB(255, 160, 42, 207),
      ),
      
    );
  }
}