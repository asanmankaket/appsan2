import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';
import '../../../models/charofname.dart';
import '../../mapbook.dart';

class BookdetailFinish extends StatefulWidget {
  const BookdetailFinish({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<BookdetailFinish> createState() => _BookdetailFinishState();
}

class _BookdetailFinishState extends State<BookdetailFinish> {
  get children => null;
  late String result;
  dynamic worktype;

  @override
  void initState() {
    // TODO: implement initState
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
            const SizedBox(
              height: 40,
            ),
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
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: const Color.fromARGB(255, 150, 217, 234),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('ราคาต่อชั่วโมง ${widget.data['book_result']}',
                        style: const TextStyle(fontSize: 17)),
                    const SizedBox(height: 5),
                    Text(
                      'วันที่ : ' +
                          DateFormat('dd-mm-yy KK:MM').format(DateTime.parse(
                              '${widget.data['book_starttime']}')),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      'เวลาตั้งเเต่ :  ' +
                          DateFormat('dd-mm-yy KK:MM').format(
                              DateTime.parse('${widget.data['book_endtime']}')),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(width: 25),
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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  primary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              onPressed: () {
                startScan();
              },
              child: SizedBox(
                width: 170,
                height: 30,
                // ignore: prefer_const_literals_to_create_immutables
                child: Wrap(children: [
                  const Icon(Icons.check),
                  const SizedBox(width: 20),
                  const Text(
                    'ยืนยันจบงาน',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  startScan() async {
    print("-------------------------------------------------id   :" +
        widget.data['book_id'].toString());
    String? scanResult = await scanner.scan();

    print(scanResult);
    scanResult == widget.data['book_id'].toString()
        ? {
            confirmBook(widget.data['book_id'], 2, context),
          }
        : EasyLoading.showError('Qrcode ไม่ถูกต้อง');
  }
}
