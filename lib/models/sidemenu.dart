import 'package:creative/configs/api.dart';
import 'package:creative/models/button_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login/login.dart';
import 'charofname.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    this.routeName,
  }) : super(key: key);

  final String? routeName;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  dynamic data, typework;
  late String addimage;
  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    //เอาตัวidของcustomerมาใช้กับหน้านี้แล้วเอาค่าไปใส่ในidUser
    dynamic item = await getProfile(); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
      data['men_image'] != null
          ? addimage = data['men_image'].toString()
          : addimage =
              "https://lvspvwkgiozgxaoaurky.supabase.co/storage/v1/object/public/avatar/user.png";
      data['men_type'] != null
          ? typework = typeWork(int.parse(data['men_type']))
          : typework = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 76, 124, 172),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: data != null
                    ? GestureDetector(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(addimage),
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data['men_username']}\n${data['men_fname']}  ${data['men_lname']}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'ประเภทการดูแล: $typework',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : const CupertinoActivityIndicator(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const ButtonSidemenu(
                    next: Icons.house, text: "หน้าหลัก", page: 0),
                const SizedBox(height: 15),
                const ButtonSidemenu(
                    next: Icons.event_note, text: "นัดหมาย", page: 1),
                const SizedBox(height: 15),
                const ButtonSidemenu(
                    next: Icons.settings_backup_restore,
                    text: "ดูประวัติ",
                    page: 2),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(97, 20, 92, 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                backgroundColor: Colors.red,
                primary: const Color.fromARGB(255, 255, 255, 255),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                      //แก้ตรงนี้--------------------------------------------------------------------------------------
                    ),
                    (route) => false);
              },
              child: const Text(
                'ออกจากระบบ',
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile routeItem(BuildContext context, Widget? leading, String name,
      String routeItemName) {
    return ListTile(
      selected: widget.routeName == routeItemName,
      selectedColor: Colors.lightGreen,
      leading: leading,
      title: Text(name),
      onTap: () {
        widget.routeName == routeItemName
            ? Navigator.pop(context, true)
            : Navigator.pushReplacementNamed(context, routeItemName);
      },
    );
  }
}
