import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/api.dart';

class NextRegister extends StatefulWidget {
  NextRegister(
      {Key? key,
      required this.username,
      required this.password,
      required this.name,
      required this.surname,
      required this.picdate})
      : super(key: key);
  String username, password, name, surname, picdate;
  @override
  State<NextRegister> createState() => _Register();
}

class _Register extends State<NextRegister> {
  TextEditingController citizenId = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController latilongti = TextEditingController();
  TextEditingController skill = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  File? file;

  DateTime? datenow = DateTime.now();

  String? dropdownValue = 'address';
  List<DropdownMenuItem<String>>? items = [
    const DropdownMenuItem(
      value: 'value',
      child: Text(
        'สงขลา',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ),
    const DropdownMenuItem(
      value: 'address',
      child: Text(
        'สตูล',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  height: 10,
                ),
                TextFormField(
                  controller: phonenumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'โปรดกรอกหมายเลขโทรศัพท์';
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
                    labelText: 'เบอร์โทรศัพท์',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you Usename for display',
                    hintText: 'เบอร์โทรศัพท์',
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
                      Icons.add_call,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: citizenId,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'โปรดกรอกหมายเลขบัตรประชาชน';
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
                    labelText: 'หมายเลขบัตรประชาชน',
                    labelStyle: TextStyle(color: Colors.white),
                    helperText: 'Tyep you password more 6 Charactor',
                    hintText: 'หมายเลขบัตรประชาชน',
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
                      Icons.assignment_ind,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 36.0,
                      ),
                      onPressed: () => chooseImage(ImageSource.camera),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: file == null
                          ? Image.asset('assets/images/one.jpg')
                          : Image.file(file!),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_photo_alternate,
                        size: 36.0,
                      ),
                      onPressed: () => chooseImage(ImageSource.gallery),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: latilongti,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'กรุณาตรวจสอบตำเเหน่งของท่าน';
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
                          labelText: 'ตำเเหน่ง',
                          labelStyle: TextStyle(color: Colors.white),
                          helperText: 'Tyep you password more 6 Charactor',
                          hintText: 'ตำเเหน่ง',
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
                            Icons.badge,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: skill,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'กรุณากรอกทักษะของท่านให้เรียบร้อย';
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
                          labelText: 'ทักษะ',
                          labelStyle: TextStyle(color: Colors.white),
                          helperText: 'Tyep you password more 6 Charactor',
                          hintText: 'ทักษะ',
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
                            Icons.handyman,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  items: items,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      dropdownValue = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'สถานที่',
                    helperText: 'Tyep you password more 6 Charactor',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255),
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                    }

                    // Navigator.push(
                    // context,
                    // MaterialPageRoute<void>(
                    //     builder: (BuildContext context) => NextRegister()));

                    print('สมัครสมาชิก');
                    print(widget.username);
                    checkRegister(
                        widget.username,
                        widget.password,
                        widget.name,
                        widget.surname,
                        widget.picdate,
                        phonenumber.text,
                        citizenId.text,
                        context);

                    // await checkRegister(username.text, password.text, name.text,
                    //     surname.text, picdate.text, context);

                    // Navigator.pushNamedAndRemoveUntil(context,
                    //     "/Page1", (Route<dynamic> route) => false);
                  },
                  child: Text(
                    'Confirm',
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

Future<Null> chooseImage(ImageSource imageSource) async {
  try {
    var object = await ImagePicker()
        .getImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);

    setState(() {
      File file = File(object!.path);
    });
  } catch (e) {}
}

void setState(Null Function() param0) {}

Widget grorpImage() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
        icon: Icon(
          Icons.add_a_photo,
          size: 36.0,
        ),
        onPressed: () {},
      ),
    ],
  );
}
