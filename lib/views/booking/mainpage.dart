import 'package:creative/models/avatar.dart';
import 'package:creative/models/charofname.dart';
import 'package:creative/views/booking/edit_view/edit_data.dart';
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
          backgroundColor: Colors.deepPurple,
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
      // backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                stops: [0.4, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.white
                ])),
        child: dataProfile != null
            ? dataProfile['men_status'] == '0'
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40))),
                            child: ListTile(
                              leading: const Icon(
                                Icons.access_time,
                                color: Colors.yellow,
                                size: 80,
                              ),
                              title: const Text('โปรดรอ'),
                              subtitle: Text(
                                  'ยังไม่ได้รับการอนุมัติจากเจ้าหน้าที่\nโปรดเช็คข้อมูลว่ากรอกครบถ้วนแล้ว\nวันที่สมัคร : ' +
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.parse(
                                              '${dataProfile['men_dateregis']}')),
                                  style: const TextStyle(fontSize: 15)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : dataProfile['men_status'] == '2'
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40))),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.priority_high,
                                    color: Colors.red,
                                    size: 80,
                                  ),
                                  title: const Text('ไม่ได้รับการอนุมัติ'),
                                  subtitle: Text(
                                      'วันที่ : ' +
                                          DateFormat('dd/MM/yyyy').format(
                                              DateTime.parse(
                                                  '${dataProfile['men_dateregis']}')) +
                                          '\nการสมัครสมาชิกของคุณไม่ได้รับการอนุมัติ\nเหตุผล : ${dataProfile['men_note']}',
                                      style: const TextStyle(fontSize: 15)),
                                ),
                              ),
                            ),
                          ],
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 5,
                                  color: Colors.white,
                                  shadowColor: Colors.grey,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                  backgroundImage: NetworkImage(
                                                      data[i]['cust_image']),
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
                                                    fillColor:
                                                        const Color(0xFFF5F6F9),
                                                    child: typeIcon(
                                                        data[i]['book_type']),
                                                    padding:
                                                        const EdgeInsets.all(8),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${data[i]['cust_title']} ${data[i]['cust_fname']} ${data[i]['cust_lname']}',
                                                    style: const TextStyle(
                                                        fontSize: 17)),
                                                const SizedBox(height: 7),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_month_outlined,
                                                      color: Colors.green,
                                                    ),
                                                    Text(
                                                        ' เริ่ม : ' +
                                                            DateFormat(
                                                                    'dd/MM/yyyy')
                                                                .format(DateTime
                                                                    .parse(
                                                                        '${data[i]['book_startdate']}')),
                                                        style: const TextStyle(
                                                            fontSize: 16)),
                                                  ],
                                                ),
                                                const SizedBox(height: 3),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: Colors.red),
                                                    Text(
                                                        ' สิ้นสุด : ' +
                                                            DateFormat(
                                                                    'dd/MM/yyyy ')
                                                                .format(DateTime
                                                                    .parse(
                                                                        '${data[i]['book_enddate']}')),
                                                        style: const TextStyle(
                                                            fontSize: 16)),
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
                                                        style: const TextStyle(
                                                            fontSize: 16)),
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
                      )
            : const Center(
                child: CupertinoActivityIndicator(),
              ),
      ),
      drawer: const SideMenu(),
    );
  }
}
