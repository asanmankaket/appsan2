import 'dart:io';
import 'package:creative/models/textformfieldmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
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
  TextEditingController rate = TextEditingController();
  late int _currentIntValue = 32;
  final _formkey = GlobalKey<FormState>();

  File? file;

  DateTime? datenow = DateTime.now();

  String? dropdownValue;
  List<DropdownMenuItem<String>>? items = [
    const DropdownMenuItem(
      value: '0',
      child: Text(
        'ดูแลเด็ก',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ),
    const DropdownMenuItem(
      value: '1',
      child: Text(
        'ดูแลผู้ป่วย',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      ),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Text(
        'ดูแลผู้สูงอายุ',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                const SizedBox(height: 10),
                TextFieldRegis(
                  maxlength: 10,
                  labeltext: 'เบอร์โทรศัพท์',
                  controller: phonenumber,
                  textEmpty: 'โปรดกรอกหมายเลขโทรศัพท์',
                ),
                const SizedBox(height: 10),
                TextFieldRegis(
                  maxlength: 13,
                  labeltext: 'หมายเลขบัตรประชาชน',
                  controller: citizenId,
                  textEmpty: 'โปรดกรอกหมายเลขบัตรประชาชน',
                ),
                const SizedBox(height: 10),
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
                      child: DropdownButtonFormField<String>(
                        value: dropdownValue,
                        items: items,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'ประเภทการทำงาน',
                          helperText: 'Tyep you password more 6 Charactor',
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
                TextFormField(
                  readOnly: true,
                  controller: rate,
                  onTap: (() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text('ค่าแรงต่อชั่วโมงโดยเฉลี่ย'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('32 บาทต่อชั่วโมง'),
                                  NumberPicker(
                                    value: _currentIntValue,
                                    minValue: 0,
                                    maxValue: 100,
                                    step: 1,
                                    haptics: true,
                                    onChanged: (value) => setState(() {
                                      _currentIntValue = value;
                                    }),
                                  ),
                                  Text('Current value:' +
                                      _currentIntValue.toString()),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context,
                                            rate.text =
                                                _currentIntValue.toString());
                                      },
                                      child: const Text('ยืนยัน'))
                                ],
                              ),
                            ));
                  }),
                  decoration: const InputDecoration(
                    labelText: 'ค่าแรงต่อชั่วโมง',
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
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                    }
                    print(dropdownValue);

                    checkRegister(
                        widget.username,
                        widget.password,
                        widget.name,
                        widget.surname,
                        widget.picdate,
                        phonenumber.text,
                        citizenId.text,
                        "ผู้ป่วย",
                        rate.text,
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
