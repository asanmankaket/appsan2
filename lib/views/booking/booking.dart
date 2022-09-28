import 'package:creative/views/booking/detail/book_detailfinish.dart';
import 'package:flutter/material.dart';
import 'package:creative/views/booking/detail/book_detail.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('นัดหมาย'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
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
                              BookdetailFinish(data: data[i])));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.purple.shade200,
                  shadowColor: const Color.fromARGB(255, 10, 91, 111),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
                    side: BorderSide(
                      color: Colors.black.withOpacity(0.5),
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
                              SizedBox(
                                  width: 55.0,
                                  height: 55.0,
                                  child: data[i]['cust_image'] != null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              data[i]['cust_image']),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Colors.blue,
                                        )),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      'เริ่ม : ' +
                                          DateFormat('dd-mm-yy KK:MM').format(
                                              DateTime.parse(
                                                  '${data[i]['book_starttime']}')),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'ถึง :  ' +
                                          DateFormat('dd-mm-yy KK:MM').format(
                                              DateTime.parse(
                                                  '${data[i]['book_endtime']}')),
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
      drawer: const SideMenu(), //หน้าปุ่มsidemenu
    );
  }
}
