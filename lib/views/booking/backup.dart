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
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'ประวัติย้อนหลัง',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const CancleBooking()));
                }),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(110, 10, 110, 10),
                  child: const Text(
                    'ดูประวัติที่ยกเลิก',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white, primary: Colors.black),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 550, child: FinishBooking())
            ],
          ),
        ),
      ),
      drawer: const SideMenu(),
    );
  }
}
