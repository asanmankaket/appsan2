import 'package:flutter/material.dart';
import '../../configs/api.dart';
import 'package:intl/intl.dart';
import 'detail/book_detail.dart';

class CancleBooking extends StatefulWidget {
  const CancleBooking({Key? key}) : super(key: key);

  @override
  State<CancleBooking> createState() => _CancleBookingState();
}

class _CancleBookingState extends State<CancleBooking> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getdata(3); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('การนัดหมายที่ยกเลิก'),
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
                  color: const Color.fromARGB(255, 186, 198, 201),
                  shadowColor: const Color.fromARGB(255, 99, 108, 110),
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
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      'เริ่ม : ' +
                                          DateFormat('dd-mm-yy HH:mm').format(
                                              DateTime.parse(
                                                  '${data[i]['book_starttime']}')),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'ถึง :  ' +
                                          DateFormat('dd-mm-yy HH:mm').format(
                                              DateTime.parse(
                                                  '${data[i]['book_endtime']}')),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    // Text(
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
      ), //หน้าปุ่มsidemenu
    );
  }
}
