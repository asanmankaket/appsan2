import 'dart:ui';

import 'package:age_calculator/age_calculator.dart';
import 'package:creative/views/editprofile/profile_address.dart';
import 'package:creative/views/editprofile/profile_birtday.dart';
import 'package:creative/views/editprofile/setting/edit_service.dart';
import 'package:creative/views/editprofile/setting/re_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:creative/models/profilemenu.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/api.dart';
import '../models/charofname.dart';
import '../models/sidemenu.dart';
import 'bcome/_login.dart';
import 'editprofile/profile_phone.dart';
import 'editprofile/profile_photo.dart';
import 'editprofile/profilename.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic data, age, typework;
  late String birtdaytime;
  late String addimage;
  late TextEditingController title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController picdate = TextEditingController();
  DateTime? datenow = DateTime.now();

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    //เอาตัวidของcustomerมาใช้กับหน้านี้แล้วเอาค่าไปใส่ในidUser
    dynamic item = await getProfile();
    //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
      data['men_image'] != null
          ? addimage = data['men_image'].toString()
          : addimage =
              "https://lvspvwkgiozgxaoaurky.supabase.co/storage/v1/object/public/avatar/user.png";
      data['men_birtday'] != null
          ? calculatorAge(data['men_birtday'])
          : age = null;
      data['men_type'] != null
          ? typework = typeWork(int.parse(data['men_type']))
          : typework = "";
    });
  }

  calculatorAge(data) {
    birtdaytime = data;
    final dateTime = DateTime.parse(birtdaytime);
    DateDuration duration;
    duration = AgeCalculator.age(dateTime);
    setState(() {
      age = duration.years;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // endDrawer: Drawer(),
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.settings_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              })
        ],
      ),
      body: data != null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(addimage),
                        ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePhoto(
                                            dataavatar: addimage,
                                          )),
                                );
                              },
                              elevation: 2.0,
                              fillColor: const Color(0xFFF5F6F9),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.blue,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              shape: const CircleBorder(),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 227, 230, 241),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          )),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            'ประเภทการดูแล : $typework',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 43, 103, 151),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProfileMenu(
                      text:
                          '${data['men_title']} ${data['men_fname']}  ${data['men_lname']}',
                      press: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileName(data: data)));
                      }),
                  ProfileMenu(
                    text: "อายุ : " + age.toString() + " ปี",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileBirtday(data: data)),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: '${data['men_phone']}',
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProfilePhone(data: data)),
                      );
                    },
                  ),
                  ProfileMenu(
                    text:
                        '${data['men_tambons']} ${data['men_amphures']} ${data['men_provinces']}',
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileAddress(data: data)),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.purple,
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('token');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                            //แก้ตรงนี้--------------------------------------------------------------------------------------
                          ),
                          (route) => false);
                    },
                    child: const Text('ออกจากระบบ'),
                  ),
                ],
              ),
            )
          : const SizedBox(
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
      drawer: const SideMenu(),
      endDrawer: Drawer(
        backgroundColor: Colors.white70,
        child: Column(
          children: [
            Container(
              child: const Padding(
                padding: EdgeInsets.only(top: 30, left: 150),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('การตั้งค่า',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),

              // padding: EdgeInsets.all(60),
              padding: const EdgeInsets.fromLTRB(20, 43, 20, 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 160, 42, 207),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    TextButton(
                        child: const Text(
                          'เปลี่ยนรหัสผ่าน',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Repassword()));
                        }),
                    const SizedBox(height: 5),
                    TextButton(
                        child: const Text(
                          'เเก้ไขประเภทการบริการ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      EditService()));
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}
