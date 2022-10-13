import 'package:creative/models/textformfieldmodel.dart';
import 'package:flutter/material.dart';
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
  TextEditingController latilongti = TextEditingController();
  TextEditingController skill = TextEditingController();
  TextEditingController rate = TextEditingController();
  String revestWork = "";

  late int _currentIntValue = 32;
  final _formkey = GlobalKey<FormState>();

  bool isTapped = false;

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
      backgroundColor: const Color.fromARGB(255, 205, 94, 249),
      appBar: AppBar(
        title: const Text('สมัครสมาชิก'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
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
                const SizedBox(height: 30),
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
                const Text(
                  'อัตราค่าบริการโดยเฉลี่ยของแอพคือ',
                  style: TextStyle(fontSize: 20),
                ),
                const Text('32 บาท/ชั่วโมง', style: TextStyle(fontSize: 20)),
                NumberPicker(
                  value: _currentIntValue,
                  minValue: 0,
                  maxValue: 300,
                  step: 1,
                  haptics: true,
                  axis: Axis.horizontal,
                  onChanged: (value) => setState(() {
                    _currentIntValue = value;
                  }),
                ),
                Text(
                  'อัตราค่าบริการที่คุณเลือก :' + _currentIntValue.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                          _currentIntValue.toString(),
                          context);
                    }
                  },
                  child: const Text(
                    'สมัครสมาชิก',
                    style: TextStyle(
                        color: Color.fromARGB(255, 45, 134, 156),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    primary: const Color.fromARGB(255, 255, 255, 255),
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
