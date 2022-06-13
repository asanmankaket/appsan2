import 'package:flutter/material.dart';
import 'package:creative/models/profilemenu.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../configs/api.dart';
import '../models/sidemenu.dart';
import 'bcome/_login.dart';
import 'editprofile/profilename.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, this.data}) : super(key: key);
  final dynamic data;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic data;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    //เอาตัวidของcustomerมาใช้กับหน้านี้แล้วเอาค่าไปใส่ในidUser
    dynamic item = await getProfile();
    loadingDialogSuc(); //ส่งค่าไปยัง getdataหรือตัวรับapi
    setState(() {
      data = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: data != null
          ? Column(
              children: [
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      // backgroundImage: AssetImage(''),
                      backgroundColor: Colors.purple.shade300,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ProfileMenu(
                    text: '${data['title']} ${data['fname']}  ${data['lname']}',
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileName(data: data)));
                      // editThread();
                      // senddata('${widget.data['idc']}', '${widget.data['title']}',
                      //'${widget.data['fname']}', '${widget.data['lname']}'); อันนี้คือส่งข้อมูลอันเดียว
                    }),
                ProfileMenu(
                  text: '${data['birtday']}',
                  press: () {},
                ),
                ProfileMenu(
                  text: '${data['phone']}',
                  press: () {},
                ),
                ProfileMenu(
                  text: '${data['address']}',
                  press: () {},
                ),
                SizedBox(height: 20),
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
            )
          : SizedBox(
              child: loadingDialog(),
            ),
      drawer: const SideMenu(),
    );
  }

  loadingDialog() {
    EasyLoading.show(status: 'loading...');
  }

  loadingDialogSuc() {
    EasyLoading.showSuccess('Success');
  }
//   Future<Null> editThread() async{
//     showDialog(context: context, builder: (context) => SimpleDialog(
//       title: ListTile(leading: Icon(Icons.a)),
//     ));
//   }
}
