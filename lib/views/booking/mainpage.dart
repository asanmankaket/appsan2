import 'package:flutter/material.dart';
import 'package:creative/views/booking/detail/carddetail.dart';
import 'package:intl/intl.dart';
import '../../configs/api.dart';
import '../../models/sidemenu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getdata(71); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รอการยืนยัน'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      backgroundColor: Colors.purple.shade50,
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
                              Carddetail(data: data[i])));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.purple.shade100,
                  shadowColor: const Color.fromARGB(255, 10, 91, 111),
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
                                width: 15,
                              ),
                              const SizedBox(
                                width: 55.0,
                                height: 55.0,
                                child: CircleAvatar(),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(22),
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
      drawer: const SideMenu(), //หน้าปุ่มsidemenu
    );
  }
}
