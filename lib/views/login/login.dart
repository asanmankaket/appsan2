import 'package:creative/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/api.dart';
import '../battom_main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool hidepassword = true;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkToken1();
  }

  checkToken1() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      headers?['Authorization'] = "bearer ${prefs.getString('token')}";
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const BottomBarMain(index: 0)),
          (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Center(
                child: Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 124, 172),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                'แอปเพื่อผู้ดูแล',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          toolbarHeight: 150,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 70),
            Form(
              child: Center(
                child: Container(
                  height: 250.0,
                  width: 380.0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 25.0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextField(
                          controller: username,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 184, 191, 198),
                              labelText: 'ชื่อผู้ใช้',
                              labelStyle: TextStyle(color: Colors.black54),
                              hintText: 'ชื่อผู้ใช้',
                              hintStyle: TextStyle(color: Colors.black54),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 76, 124, 172),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 76, 124, 172),
                                      width: 2.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              prefixIcon: Icon(Icons.account_circle,
                                  size: 30,
                                  color: Color.fromARGB(255, 76, 124, 172))),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                            controller: password,
                            obscureText: hidepassword,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 184, 191, 198),
                                labelText: 'รหัสผ่าน',
                                hintText: 'รหัสผ่าน',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 76, 124, 172)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 76, 124, 172),
                                      width: 2.5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  size: 30,
                                  color: Color.fromARGB(255, 76, 124, 172),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: (() {
                                      setState(() {
                                        hidepassword = !hidepassword;
                                      });
                                    }),
                                    icon: Icon(
                                      hidepassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 30,
                                      color: const Color.fromARGB(
                                          255, 76, 124, 172),
                                    )))),
                        const SizedBox(height: 5),
                      ]),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                await checkLogin(username.text, password.text, context);
              },
              child: const Text(
                'เข้าสู่ระบบ',
                style: TextStyle(
                    color: Color.fromARGB(255, 76, 124, 172),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                primary: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'หรือ',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/PageOne");
              },
              child: const Text('สมัครสมาชิก',
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 124, 172),
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                primary: Colors.white,
              ),
            )
          ]),
        ));
  }
}
