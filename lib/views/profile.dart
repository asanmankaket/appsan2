import 'package:age_calculator/age_calculator.dart';
import 'package:creative/models/dialog_resendregis.dart';
import 'package:creative/views/editprofile/comment_page.dart';
import 'package:creative/views/editprofile/profile_address.dart';
import 'package:creative/views/editprofile/profile_birtday.dart';
import 'package:creative/views/editprofile/setting/edit_service.dart';
import 'package:creative/views/editprofile/setting/re_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:creative/models/profilemenu.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/api.dart';
import '../models/avatar.dart';
import '../models/charofname.dart';
import '../models/sidemenu.dart';
import 'login/login.dart';
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
  double ratting = 5;
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    //เอาตัวidของcustomerมาใช้กับหน้านี้แล้วเอาค่าไปใส่ในidUser
    dynamic item = await getProfile();
    setState(() {
      data = item;
      data['averageRatting'] != null
          ? ratting = data['averageRatting']
          : ratting = 5;
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
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        backgroundColor: Colors.deepPurple,
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
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 140,
                    width: 140,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        if (data['men_image'] != null)
                          CircleAvatar(
                            backgroundImage: NetworkImage(data['men_image']),
                            radius: 80,
                          )
                        else
                          CircleAvatar(
                            backgroundImage: avatarUser(),
                            radius: 80,
                          ),
                        Positioned(
                            bottom: 0,
                            right: -25,
                            child: RawMaterialButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePhoto(
                                            data: data,
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
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const CommentPage()));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          //ดาวคะแนน---------------------**********************************
                          rating: ratting,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Text('(${data['countScore']})'),
                      ],
                    ),
                  ),
                  ProfileMenu(
                    text: "ประเภทการดูแล  :  $typework",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  EditService(data: data['men_type'])));
                    },
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
                  const SizedBox(height: 10),
                  data['men_status'] == '2'
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const DialogReturnRegis());
                                  },
                                  child:
                                      const Text('ส่งคำขออนุมัติใหม่อีกครั้ง!'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      : Container(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.red,
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
                          ),
                          (route) => false);
                    },
                    child: const Text('ออกจากระบบ'),
                  ),
                  const SizedBox(height: 20),
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
                color: Colors.deepPurple,
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
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: TextButton.styleFrom(
                          primary: Colors.purple,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      EditService(data: data['men_type'])));
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
