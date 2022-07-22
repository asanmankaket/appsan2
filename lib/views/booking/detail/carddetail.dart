import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'Map.dart';
import '../../battom_main.dart';

class Carddetail extends StatefulWidget {
  const Carddetail({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<Carddetail> createState() => _CarddetailState();
}

class _CarddetailState extends State<Carddetail> {
  get childrer => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลลูกค้า'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              //รูปavatar
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Color.fromARGB(255, 45, 134, 156),
                // backgroundImage: ('widget.data['image']'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              '${widget.data['cust_title']} ${widget.data['cust_fname']} ${widget.data['cust_lname']}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'เวลานัด',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: const Color.fromARGB(255, 150, 217, 234),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      ' วันเริ่ม ' +
                          DateFormat('  dd-mm-yy    KK:MM').format(
                              DateTime.parse(
                                  '${widget.data['book_starttime']}')),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'สิ้นสุด' +
                          DateFormat('  dd-mm-yy    KK:MM').format(
                              DateTime.parse('${widget.data['book_endtime']}')),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'อายุ 68 ปี',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'โรคประจำตัว',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '- โรคหัวใจ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '- โรคเบาหวาน',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '- โรคความดัน',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ลักษณะผู้ป่วย',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 70),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '- ผู้ป่วยติดเตียง',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                child: Row(
              children: [
                const SizedBox(width: 30),
                // ignore: prefer_const_constructors
                Icon(
                  Icons.call,
                  color: Colors.blue,
                  size: 30,
                ),
                Text(
                  '   ${widget.data['cust_phone']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 120),
              ],
            )),
            const SizedBox(height: 10),
            Row(children: [
              Row(
                children: [
                  const SizedBox(width: 25),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute<void>(
                      //         builder: (BuildContext context) =>
                      //             GoogleMaps()));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.map,
                          size: 30,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          '''${widget.data['adr1']}
${widget.data['adr2']} ${widget.data['city']}''',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonTheme(
                  minWidth: 150.0,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        primary: const Color.fromARGB(255, 203, 41, 0)),
                    onPressed: () {
                      confirmBook(widget.data['book_id'], 3, context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BottomBarMain(index: 1)),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      'ยกเลิก',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 13),
                ButtonTheme(
                  minWidth: 150.0,
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        primary: Colors.green),
                    onPressed: () {
                      confirmBook(widget.data['book_id'], 1, context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => BottomBarMain(index: 1)),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text(
                      'ยืนยัน',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
