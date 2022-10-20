import 'package:creative/views/booking/edit_view%20%5Bmain%5D/edit_data.dart';
import 'package:flutter/cupertino.dart';

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
  dynamic dataProfile;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getdata(0);
    dynamic item1 = await getProfile();

    setState(() {
      data = item;
      dataProfile = item1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('รอการยืนยัน'),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 76, 124, 172),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Editdata()));
                })
          ]),
      backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      body: dataProfile != null
          ? dataProfile['men_status'] == '0'
              ? Container(
                  decoration: const BoxDecoration(
                      color: Colors.white, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  width: 400,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'ยังไม่ได้รับการอนุมัติจากเจ้าหน้าที่\nโปรดรอ',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Padding(
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
                                        Carddetail(data: data[i])));
                          },
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            shadowColor:
                                const Color.fromARGB(255, 76, 124, 172),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(width: 30),
                                        SizedBox(
                                            width: 100.0,
                                            height: 100.0,
                                            child: data[i]['cust_image'] != null
                                                ? CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(data[i]
                                                            ['cust_image']),
                                                  )
                                                : const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue,
                                                  )),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(22),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                'เริ่ม : ' +
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            '${data[i]['book_startdate']}')),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                'ถึง :  ' +
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            '${data[i]['book_enddate']}')),
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                data[i]['book_starttime'] +
                                                    "  จนถึงเวลา  " +
                                                    data[i]['book_endtime'],
                                                style: const TextStyle(
                                                  fontSize: 15,
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
                )
          : const Center(
              child: CupertinoActivityIndicator(),
            ),
      drawer: const SideMenu(),
    );
  }
}
