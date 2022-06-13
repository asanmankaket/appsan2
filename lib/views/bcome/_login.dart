import 'package:creative/configs/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api.dart';

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
      Navigator.pushNamedAndRemoveUntil(
          context, "/MainPage", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AppMentor'),
          backgroundColor: Color.fromARGB(255, 160, 42, 207),
        ),
        backgroundColor: Colors.purple.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    // Icon(Icons.wheelchair_pickup, size: 50),
                    Text(
                      'Login Account',
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'appication for mentor',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: 250.0,
                              width: 380.0,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 25.0,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextField(
                                        controller: username,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.purple.shade100,
                                            labelText: 'username',
                                            hintText: 'ชื่อผู้ใช้',
                                            hintStyle:
                                                TextStyle(color: Colors.purple),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.purple,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple,
                                                    width: 2.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100))),
                                            prefixIcon: Icon(
                                              Icons.account_circle,
                                              size: 30,
                                              color: Colors.purple,
                                            )),
                                      ),
                                      SizedBox(height: 20),
                                      TextField(
                                          controller: password,
                                          obscureText: hidepassword,
                                          // ignore: prefer_const_constructors
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.purple.shade100,
                                              labelText: 'password',
                                              hintText: 'รหัสผ่าน',
                                              hintStyle: TextStyle(
                                                  color: Colors.purple),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.purple),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50))),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.purple,
                                                    width: 2.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                size: 30,
                                                color: Colors.purple,
                                              ),
                                              suffixIcon: IconButton(
                                                  onPressed: (() {
                                                    setState(() {
                                                      hidepassword =
                                                          !hidepassword;
                                                    });
                                                  }),
                                                  icon: Icon(
                                                    hidepassword
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    size: 30,
                                                    color: Colors.purple,
                                                  )))),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Foeget Password ?',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        await checkLogin(username.text, password.text, context);
                        // Navigator.pushNamedAndRemoveUntil(context,
                        //     "/Page1", (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        primary: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'or',
                      style: TextStyle(color: Colors.purple),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/PageOne");
                        // Navigator.pushNamed(context, "/PageOne");
                      },
                      child: Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        primary: Colors.purple,
                      ),
                    )
                  ])),
            ),
          ),
        ));
  }
}
