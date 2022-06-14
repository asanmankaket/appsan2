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
                '${widget.data['title']} ${widget.data['fname']} ${widget.data['lname']}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
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
                      Text(
                        'วันที่ : ' +
                            DateFormat('dd-mm-yy KK:MM').format(
                                DateTime.parse('${widget.data['start_time']}')),
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
                                DateTime.parse('${widget.data['end_time']}')),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ClipRRect(
                // borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'อายุ 68 ปี',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'โรคประจำตัว',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '- โรคหัวใจ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '- โรคเบาหวาน',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '- โรคความดัน',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'ลักษณะผู้ป่วย',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    // Text('ราคาต่อชั่วโมง ${widget.data['rate']}',
                    //     style: TextStyle(fontSize: 18)),
                    // Text('${widget.data['type']}',
                    //     style: TextStyle(fontSize: 18)),
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
                        '   ${widget.data['phone']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
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
                      const Icon(
                        Icons.map,
                        color: Colors.blue,
                      ),
                      Text(
                        '''   ${widget.data['adr1']} ${widget.data['adr2']} 
    ${widget.data['city']}''',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
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
