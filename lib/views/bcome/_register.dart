import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'next_register.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _Register();
}

class _Register extends State<PageOne> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController picdate = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  DateTime? datenow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    void newDate() async {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: datenow!,
          firstDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month, 30));
      if (date != null) {
        setState(() {
          datenow = date;
          picdate.text = DateFormat("dd/MM/yyyy").format(date);
          DateFormat("dd/MM/yyyy").format(date);
        });
      }
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 205, 94, 249),
      appBar: AppBar(
        title: Text('สมัครสมาชิก'),
        backgroundColor: Color.fromARGB(255, 160, 42, 207),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //username
                TextFormField(
                  controller: username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you Usename in the blank';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                      labelText: 'Usename',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      helperText: 'Tyep you Usename for display',
                      hintText: 'Usename',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                //รหัสผ่าน
                TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'Password More 6 Charactor';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'password',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    helperText: 'Tyep you password more 6 Charactor',
                    hintText: 'password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //ยืนยันรหัสผ่าน
                TextFormField(
                  controller: confirmpassword,
                  validator: (value) {
                    if (confirmpassword != password) {
                      return 'password not same';
                    }
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'confirm password',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    helperText: 'Tyep confirm password for display',
                    hintText: 'confirm password',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      //name
                      child: TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please fill you surname in the blank';
                          } else {
                            return null;
                          }
                        },

                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          print(value);
                        },
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          helperText: 'Tyep you surname for display',
                          hintText: 'Name',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 240, 4, 4)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(
                            Icons.person,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      //surname
                      child: TextFormField(
                        controller: surname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please fill you surname in the blank';
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          print(value);
                        },
                        maxLines: 1,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          helperText: 'Tyep you name for display',
                          hintText: 'Last name',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 240, 4, 4)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(
                            Icons.person,
                            size: 30,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill you date in the blank';
                    } else {
                      return null;
                    }
                  },
                  controller: picdate,
                  readOnly: true,
                  onTap: () {
                    newDate();
                  },
                  style: TextStyle(
                      color: Color.fromARGB(255, 244, 4, 4), fontSize: 17),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    print(value);
                  },
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'date',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    helperText: 'Tyep you date for display',
                    hintText: 'date',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 206, 6, 6)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => NextRegister(
                                username: username.text,
                                password: password.text,
                                name: name.text,
                                surname: surname.text,
                                picdate: picdate.text)));
                  },
                  child: Text(
                    'ถัดไป',
                    style: TextStyle(
                        color: Color.fromARGB(255, 45, 134, 156),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    primary: Color.fromARGB(255, 255, 255, 255),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
