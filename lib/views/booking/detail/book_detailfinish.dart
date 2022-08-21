import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../../battom_main.dart';
import '../../mapbook.dart';

class BookdetailFinish extends StatefulWidget {
  const BookdetailFinish({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<BookdetailFinish> createState() => _BookdetailFinishState();
}

class _BookdetailFinishState extends State<BookdetailFinish> {
  get children => null;
  TextEditingController type = TextEditingController();
  late String result = "";
  @override
  void initState() {
    super.initState();
    widget.data['book_type'] == '0'
        ? type.text = "ดูแลเด็ก"
        : widget.data['book_type'] == '1'
            ? type.text = "ดูแลผู้ป่วย"
            : widget.data['book_type'] == '2'
                ? type.text = "ดูแลผู้สูงอายุ"
                : type.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลลูกค้า'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Center(
                //รูปavatar
                child: CircleAvatar(
                  radius: 70,
                  // backgroundImage: ('${widget.data['image']}'),
                  backgroundColor: Color.fromARGB(255, 45, 134, 156),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${widget.data['cust_title']} ${widget.data['cust_fname']} ${widget.data['cust_lname']}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                            DateFormat('dd-mm-yy KK:MM').format(DateTime.parse(
                                '${widget.data['book_endtime']}')),
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
                      "" + type.text,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 40,
                        ),
                      ),
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
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: SizedBox(width: 39),
                    ),
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
                          const Icon(Icons.map, size: 30),
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
              ]),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () {
                    startScan();
                  },
                  child: const Text('จบงาน')),
              Text('ผลการจบงาน'),
              Text(result)
            ],
          ),
        ),
      ),
    );
  }

  startScan() async {
    String cameraScanResult = await scanner.scan() as String;
    print(cameraScanResult);
    setState(() {
      result = cameraScanResult;
    });
    result == widget.data['book_id'].toString()
        ? {
            confirmBook(widget.data['book_id'], 2, context),
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => BottomBarMain(index: 0)),
                (Route<dynamic> route) => false)
          }
        : AlertDialog(
            content: Text('QRCode ไม่ถูกต้อง'),
          );
  }
}
