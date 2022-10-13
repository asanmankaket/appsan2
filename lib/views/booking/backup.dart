import 'package:flutter/material.dart';
import '../../models/sidemenu.dart';
import 'cancle_book.dart';
import 'finish_book.dart';

class BackUp extends StatelessWidget {
  const BackUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติย้อนหลัง'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            height: 150,
            width: 150,
            child: TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const FinishBooking()));
              }),
              child: const Text('ดูประวัติที่สำเร็จ'),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 160, 42, 207),
                  primary: Colors.white),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(8),
            height: 150,
            width: 150,
            child: TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const CancleBooking()));
              }),
              child: const Text(
                'ดูประวัติที่ยกเลิก',
              ),
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 160, 42, 207),
                  primary: Colors.white),
            ),
          ),
        ],
      ),
      drawer: const SideMenu(),
    );
  }
}
