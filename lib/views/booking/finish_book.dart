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
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
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
              color: const Color.fromARGB(255, 76, 124, 172),
              shadowColor: const Color.fromARGB(255, 76, 124, 172),
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
                          const SizedBox(width: 30),
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: data[i]['cust_image'] != null
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data[i]['cust_image']),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                    )),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.all(22),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  'เริ่ม : ' +
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(
                                              '${data[i]['book_startdate']}')),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  'สิ้นสุด : ' +
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.parse(
                                              '${data[i]['book_enddate']}')),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  data[i]['book_starttime'] +
                                      "จนถึงเวลา" +
                                      data[i]['book_endtime'],
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
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
    );
  }
}
