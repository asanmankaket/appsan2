import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/charofname.dart';
import '../../mapbook.dart';
import '../../battom_main.dart';
import 'package:url_launcher/url_launcher.dart';

class Carddetail extends StatefulWidget {
  const Carddetail({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<Carddetail> createState() => _CarddetailState();
}

class _CarddetailState extends State<Carddetail> {
  get childrer => null;
  dynamic worktype;

  @override
  void initState() {
    super.initState();
    if (widget.data['book_type'] != null) {
      worktype = typeWork(int.parse(widget.data['book_type']));
    } else {
      worktype = "";
    }
  }

  _makingPhoneCall(phone) async {
    var url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            const SizedBox(height: 40),
            Center(
                //รูปavatar
                child: widget.data['cust_image'] != null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            NetworkImage(widget.data['cust_image']),

                        // backgroundImage: ('widget.data['image']'),
                      )
                    : const CircleAvatar(
                        radius: 70,
                        backgroundColor: Color.fromARGB(255, 45, 134, 156),
                      )),
            const SizedBox(height: 15),
            Text(
              '${widget.data['cust_title']} ${widget.data['cust_fname']} ${widget.data['cust_lname']}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("ยอดรวมทั้งหมดคือ : ${widget.data['book_result']}  บาท"),
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
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: const Color.fromARGB(255, 150, 217, 234),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      ' ตั้งแต่วันที่ : ' +
                          DateFormat('  dd-mm-yy ').format(DateTime.parse(
                              '${widget.data['book_startdate']}')),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'จนถึงวันที่ :' +
                          DateFormat('  dd-mm-yy  ').format(
                              DateTime.parse('${widget.data['book_enddate']}')),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text('ตั้งแต่เวลา : ' +
                        widget.data['book_starttime'] +
                        "  จนถึงเวลา  " +
                        widget.data['book_endtime']),
                  ],
                ),
              ),
            ),
            ClipRRect(
              // borderRadius: BorderRadius.circular(10.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'ประเภทงาน',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    worktype,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 25),
                TextButton(
                  onPressed: () {
                    _makingPhoneCall(widget.data['cust_phone']);
                  },
                  child: SizedBox(
                      child: Row(
                    children: [
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
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 25),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => GoogleMaps(
                                  data: widget.data,
                                )));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.map,
                        size: 30,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '''${widget.data['book_pinhome']} ${widget.data['book_tambons']} 
${widget.data['book_amphures']} ${widget.data['book_provinces']}''',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
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
                              builder: (context) => const BottomBarMain(index: 1)),
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
                              builder: (context) => const BottomBarMain(index: 1)),
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
