import 'package:flutter/material.dart';
import '../../configs/api.dart';

import 'package:intl/intl.dart';

import 'detail/book_detail.dart';

class FinishBooking extends StatefulWidget {
  const FinishBooking({Key? key}) : super(key: key);

  @override
  State<FinishBooking> createState() => _FinishBookingState();
}

class _FinishBookingState extends State<FinishBooking> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getdata(2); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การนัดหมายที่สำเร็จ'),
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
                              Bookdetail(data: data[i])));
                },
                child: Card(
                  elevation: 10,
                  color: const Color.fromARGB(255, 111, 210, 174),
                  shadowColor: const Color.fromARGB(255, 148, 148, 148),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27),
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
                                padding: const EdgeInsets.all(22),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(height: 5),
                                    Text('เริ่ม : ' +
                                        DateFormat('dd-mm-yy').format(
                                            DateTime.parse(
                                                '${data[i]['book_startdate']}'))),
                                    const SizedBox(height: 5),
                                    Text('สิ้นสุด : ' +
                                        DateFormat('dd-mm-yy').format(
                                            DateTime.parse(
                                                '${data[i]['book_enddate']}'))),
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
    );
  }
}
