import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/charofname.dart';
import '../../mapbook.dart';

class Bookdetail extends StatefulWidget {
  const Bookdetail({Key? key, required this.data}) : super(key: key);

  final dynamic data;
  @override
  State<Bookdetail> createState() => _BookdetailState();
}

class _BookdetailState extends State<Bookdetail> {
  get children => null;
  TextEditingController type = TextEditingController();
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
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ตั้งแต่วันที่ : ' +
                            DateFormat('dd-mm-yy KK:MM').format(DateTime.parse(
                                '${widget.data['book_startdate']}')),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        'จนถึงวันที่ :  ' +
                            DateFormat('dd-mm-yy ').format(DateTime.parse(
                                '${widget.data['book_enddate']}')),
                        style: const TextStyle(
                          fontSize: 16,
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
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              ]),
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
