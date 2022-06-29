import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:creative/views/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/bcome/_login.dart';

class SettingManu extends StatefulWidget {
  const SettingManu({
    Key? key,
    this.routeName,
  }) : super(key: key);

  final String? routeName;

  @override
  State<SettingManu> createState() => _SettingManuState();
}

class _SettingManuState extends State<SettingManu> {
  dynamic data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Drawer Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: _openEndDrawer,
          child: const Text('Open End Drawer'),
        ),
      ),
      endDrawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('This is the Drawer'),
              ElevatedButton(
                onPressed: _closeEndDrawer,
                child: const Text('Close Drawer'),
              ),
            ],
          ),
        ),
      ),
      // Disable opening the end drawer with a swipe gesture.
      endDrawerEnableOpenDragGesture: false,
    );
  }

//   // ListTile routeItem(BuildContext context, Widget? leading, String name,
//   //     String routeItemName) {
//   //   return ListTile(
//   //     selected: widget.routeName == routeItemName,
//   //     selectedColor: Colors.lightGreen,
//   //     leading: leading,
//   //     title: Text(name),
//   //     onTap: () {
//   //       widget.routeName == routeItemName
//   //           ? Navigator.pop(context, true)
//   //           : Navigator.pushReplacementNamed(context, routeItemName);
//   //     },
//   //   );
//   // }
}
