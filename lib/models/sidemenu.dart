import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:creative/views/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/bcome/_login.dart';

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
  dynamic data;

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
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 160, 42, 207),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                Profile(data: data)));
                  }),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                        backgroundColor: Colors.white,
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            data != null
                                ? Text(
                                    '''${data['username']}
${data['fname']}  ${data['lname']}''',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(''),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                routeItem(
                  context,
                  Icon(Icons.house),
                  //แก้ตรงนี้--------------------------------------------------------------------------------------
                  'หน้าหลัก',
                  '/MainPage',
                ),
                routeItem(
                  context,
                  Icon(Icons.event_note),
                  //แก้ตรงนี้--------------------------------------------------------------------------------------
                  'นัดหมาย',
                  '/book',
                ),
                routeItem(
                  context,
                  Icon(Icons.settings_backup_restore),
                  //แก้ตรงนี้--------------------------------------------------------------------------------------
                  'ดูประวัติ',
                  '/Backup',
                ),
                routeItem(
                  context,
                  Icon(Icons.map),
                  //แก้ตรงนี้--------------------------------------------------------------------------------------
                  'Map',
                  '/Map',
                ),
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
                backgroundColor: Colors.purple,
                primary: const Color.fromARGB(255, 255, 255, 255),
                textStyle: const TextStyle(fontSize: 20),
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
