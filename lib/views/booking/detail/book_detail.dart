import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bookdetail extends StatefulWidget {
  const Bookdetail({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<Bookdetail> createState() => _BookdetailState();
}

class _BookdetailState extends State<Bookdetail> {
  get children => null;
  TextEditingController type = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    widget.data['book_type'] == '0'
        ? type.text = "เด็ก"
        : widget.data['book_type'] == '1'
            ? type.text = "ผู้ป่วย"
            : widget.data['book_type'] == '2'
                ? type.text = "ผู้สูงอายุ"
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
                          style: TextStyle(fontSize: 17)),
                      SizedBox(
                        height: 5,
                      ),
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
                      type.text,
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
                        padding: EdgeInsets.only(left: 40),
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
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
