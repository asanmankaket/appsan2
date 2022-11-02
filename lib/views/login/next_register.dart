// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:creative/models/textformfieldmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../configs/api.dart';

class NextRegister extends StatefulWidget {
  const NextRegister(
      {Key? key,
      required this.username,
      required this.password,
      required this.name,
      required this.title,
      required this.surname,
      required this.picdate})
      : super(key: key);
  final String title, username, password, name, surname, picdate;
  @override
  State<NextRegister> createState() => _Register();
}

class _Register extends State<NextRegister> {
  TextEditingController citizenId = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  dynamic data;
  int currentIntValue = 0;
  double dataDoubleValue = 0;

  @override
  void initState() {
    super.initState();
    startApi();
  }

  startApi() async {
    dynamic item = await getAvg();
    setState(() {
      data = item;
      if (data != null) {
        dataDoubleValue = data[0]['RateAvg'];
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    citizenId.dispose();
    phonenumber.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  bool isTapped = false;

  DateTime? datenow = DateTime.now();
  File? _image;
  String? dropdownValue;
  List<DropdownMenuItem<String>>? items = [
    const DropdownMenuItem(
      value: '0',
      child: Text(
        'ดูแลเด็ก',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const DropdownMenuItem(
      value: '1',
      child: Text(
        'ดูแลผู้ป่วย',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Text(
        'ดูแลผู้สูงอายุ',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];
  Future getImage(ImageSource wayimage) async {
    final image = await ImagePicker().pickImage(source: wayimage);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  stops: [0.6, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurple, Colors.white])),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 50),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ))
                ],
              ),
              const SizedBox(height: 20),
              TextFieldRegis(
                keytype: true,
                maxlength: 10,
                labeltext: 'เบอร์โทรศัพท์',
                controller: phonenumber,
                textEmpty: 'โปรดกรอกหมายเลขโทรศัพท์',
              ),
              const SizedBox(height: 10),
              TextFieldRegis(
                keytype: true,
                maxlength: 13,
                checkCiz: true,
                labeltext: 'หมายเลขบัตรประชาชน',
                controller: citizenId,
                textEmpty: 'โปรดกรอกหมายเลขบัตรประชาชน',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      items: items,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value;
                        });
                      },
                      dropdownColor: Color.fromARGB(255, 177, 153, 217),
                      decoration: const InputDecoration(
                        labelText: 'ประเภทการทำงาน',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 240, 4, 4)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                height: 281,
                width: 380,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 25.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Column(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      'อัพโหลดรูปโปรไฟล์',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        _image != null
                            ? Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                height: 200,
                                width: 200,
                                child: Image.file(_image!, fit: BoxFit.cover),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[200],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                height: 200,
                                width: 200,
                              ),
                        const SizedBox(width: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                        255, 156, 156, 156),
                                    primary: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                  child: const Icon(Icons.camera)),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 96, 192, 224),
                                    primary: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    textStyle: const TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                  },
                                  child: const Icon(Icons.photo_album)),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
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
                  children: [
                    const Text(
                      'อัตราค่าบริการโดยเฉลี่ยของแอปคือ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('$dataDoubleValue บาท/ชั่วโมง',
                        style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 15),
                    SpinBox(
                      max: 300,
                      min: 1,
                      value: dataDoubleValue,
                      onChanged: (value) {
                        currentIntValue = value.toInt();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState?.save();

                    checkRegister(
                        widget.title,
                        widget.username,
                        widget.password,
                        widget.name,
                        widget.surname,
                        widget.picdate,
                        phonenumber.text,
                        citizenId.text,
                        dropdownValue!,
                        currentIntValue.toString(),
                        _image,
                        datenow.toString(),
                        context);
                  }
                },
                child: const Text(
                  'สมัครสมาชิก',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    primary: Colors.white),
              ),
              const SizedBox(height: 50)
            ]),
          ),
        ),
      ),
    );
  }
}
