import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_appcare/views/book_detail.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sidemenu.dart';
import 'mainpage.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  dynamic data;

  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    final prefs =
        await SharedPreferences.getInstance(); //เพิ่มตัวแชร์จากหน้าlogin
    int? idUser = prefs.getInt('idm');
    dynamic item = await Getdata(idUser); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('นัดหมาย'),
        backgroundColor: Color.fromARGB(255, 160, 42, 207),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.timelapse_sharp,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       // Navigator.push(
        //       //     context,
        //       //     MaterialPageRoute<void>(
        //       //         builder: (BuildContext context) => WaitingBooking()));

        //       // do something
        //     },
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
            onRefresh: () async {
              startApi();
            },
            child: ListView.builder(
              itemCount:
                  data?.length ?? 0, //เอาออกไปก่อนเพราะตัวdata.lengthยังพังอยู่
              // itemCount: 3, //ใช้ตัวนี้แทนเพราะตัวdataพัง
              itemBuilder: (context, i) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              bookdetail(data: data[i])));
                },
                child: Card(
                  elevation: 10,
                  color: Color.fromARGB(255, 205, 94, 249),
                  shadowColor: Color.fromARGB(255, 10, 91, 111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                    side: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                width: 20,
                              ),
                              const SizedBox(
                                width: 55.0,
                                height: 55.0,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 211, 211, 211),
                                  foregroundColor:
                                      Color.fromARGB(255, 211, 211, 211),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[i]['title']} ${data[i]['fname']} ${data[i]['lname']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      'เริ่ม : ' +
                                          DateFormat('dd-mm-yy KK:MM').format(
                                              DateTime.parse(
                                                  '${data[i]['start_time']}')),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'ถึง :  ' +
                                          DateFormat('dd-mm-yy KK:MM').format(
                                              DateTime.parse(
                                                  '${data[i]['end_time']}')),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: SideMenu(), //หน้าปุ่มsidemenu
    );
  }
}

Future<dynamic> Getdata(dynamic idUser) async {
  Uri url = Uri.parse(
      'http://206.189.92.71:3200/api/booking/men/72/$idUser '); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  // Uri url = Uri.parse(
  //     'http://192.168.1.9:3200/api/booking/cust/$idUser'); //รับค่ามาจากiduser หรือตัวที่แชร์มาจากหน้าlogin ส่งไปยังurlเพื่อเช็คว่าคนนี้มีนัดหมายใครบ้าง
  return await http
      .get(
    url,
  )
      .then((req) async {
    print(req.statusCode);
    if (req.statusCode == 200) {
      print(req.body);
      var data = jsonDecode(req.body);
      return data;
    } else {
      print('error');
      return null;
    }
  });
}
