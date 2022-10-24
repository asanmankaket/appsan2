import 'package:creative/models/avatar.dart';
import 'package:creative/models/charofname.dart';
import 'package:creative/views/booking/detail/book_detailfinish.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../configs/api.dart';
import '../../models/sidemenu.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  dynamic data;
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getdata(1); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('การจองที่กำลังดำเนินการ'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.4, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.white])),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RefreshIndicator(
              onRefresh: () async {
                startApi();
              },
              child: ListView.builder(
                itemCount: data?.length ??
                    0, //เอาออกไปก่อนเพราะตัวdata.lengthยังพังอยู่
                // itemCount: 3, //ใช้ตัวนี้แทนเพราะตัวdataพัง
                itemBuilder: (context, i) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                BookdetailFinish(data: data[i])));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(width: 30),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                if (data[i]['cust_image'] != null)
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data[i]['cust_image']),
                                    radius: 80,
                                  )
                                else
                                  CircleAvatar(
                                    backgroundImage: avatarUser(),
                                    radius: 80,
                                  ),
                                Positioned(
                                    bottom: -15,
                                    right: -25,
                                    child: RawMaterialButton(
                                      onPressed: null,
                                      elevation: 2.0,
                                      fillColor: const Color(0xFFF5F6F9),
                                      child: typeIcon(data[i]['book_type']),
                                      padding: const EdgeInsets.all(8),
                                      shape: const CircleBorder(),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                      style: const TextStyle(fontSize: 17)),
                                  const SizedBox(height: 7),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Colors.green,
                                      ),
                                      Text(
                                          ' เริ่ม : ' +
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(
                                                      '${data[i]['book_startdate']}')),
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month_outlined,
                                          color: Colors.red),
                                      Text(
                                          ' สิ้นสุด : ' +
                                              DateFormat('dd/MM/yyyy ').format(
                                                  DateTime.parse(
                                                      '${data[i]['book_enddate']}')),
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        size: 28,
                                        color: Colors.green,
                                      ),
                                      Text(
                                          'ค่าบริการ : ${data[i]['book_result'].toStringAsFixed(0)}  บาท',
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const SideMenu(), //หน้าปุ่มsidemenu
    );
  }
}
