import 'package:creative/models/textformfieldmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'next_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _Register();
}

class _Register extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController picdate = TextEditingController();
  bool hidepassword = true;
  bool hidepassword1 = true;
  DateTime? datenow = DateTime.now();
  DateTime? selectdate;
  final _formkey = GlobalKey<FormState>();
  String? dropdownValue;
  List<DropdownMenuItem<String>>? items = [
    const DropdownMenuItem(
      value: 'นาย',
      child: Text(
        'นาย',
      ),
    ),
    const DropdownMenuItem(
      value: 'นาง',
      child: Text(
        'นาง',
      ),
    ),
    const DropdownMenuItem(
      value: 'นางสาว',
      child: Text(
        'นางสาว',
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    void newDate() async {
      selectdate = await showDatePicker(
        context: context,
        initialDate: DateTime(
          DateTime.now().year - 11,
          DateTime.now().month,
        ),
        firstDate: DateTime(
          DateTime.now().year - 80,
          DateTime.now().month,
        ),
        lastDate: DateTime(DateTime.now().year - 10, DateTime.now().month),
      );
      if (selectdate != null) {
        setState(() {
          datenow = selectdate;
          picdate.text = DateFormat("yyyy-MM-dd").format(selectdate!);
          DateFormat("yyyy-MM-dd").format(selectdate!);
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 76, 124, 172),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              const Text(
                'สมัครสมาชิก',
                style: TextStyle(fontSize: 45, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldRegis(
                labeltext: 'ชื่อผู้ใช้',
                controller: username,
                textEmpty: 'โปรดกรอกชื่อผู้ใช้',
              ),
              const SizedBox(
                height: 15,
              ),
              //รหัสผ่าน
              TextFormField(
                controller: password,
                obscureText: hidepassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'โปรดกรอกรหัสผ่าน';
                  } else {
                    return null;
                  }
                },
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: "รหัสผ่าน",
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          color: Colors.white,
                        ))),
              ),
              const SizedBox(
                height: 15,
              ),
              //ยืนยันรหัสผ่าน
              TextFormField(
                controller: confirmpassword,
                obscureText: hidepassword1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'โปรดกรอกรหัสผ่าน';
                  } else if (value != password.text) {
                    return 'รหัสผ่านไม่ตรงกัน';
                  } else {
                    return null;
                  }
                },
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                onChanged: (value) {},
                decoration: InputDecoration(
                    labelText: "ยืนยันรหัสผ่าน",
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 240, 4, 4)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    suffixIcon: IconButton(
                        onPressed: (() {
                          setState(() {
                            hidepassword1 = !hidepassword1;
                          });
                        }),
                        icon: Icon(
                          hidepassword1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 30,
                          color: Colors.white,
                        ))),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: dropdownValue,
                items: items,
                onChanged: (value) {
                  dropdownValue = value;
                },
                dropdownColor: const Color.fromARGB(255, 154, 184, 213),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'คำนำหน้า',
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFieldRegis(
                      controller: name,
                      textEmpty: 'โปรดกรอกชื่อ',
                      labeltext: 'ชื่อ',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFieldRegis(
                      controller: surname,
                      textEmpty: 'โปรดกรอกนามสกุล',
                      labeltext: 'นามสกุล',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'โปรดเลือกวันเดือนปีเกิด';
                  } else {
                    return null;
                  }
                },
                controller: picdate,
                readOnly: true,
                onTap: () {
                  newDate();
                },
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                keyboardType: TextInputType.text,

                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: 'วันเดือนปีเกิด',
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  hintText: 'วันเดือนปีเกิด',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 206, 6, 6)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  prefixIcon: const Icon(
                    Icons.date_range,
                    size: 30,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState?.save();
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => NextRegister(
                                title: dropdownValue!,
                                username: username.text,
                                password: password.text,
                                name: name.text,
                                surname: surname.text,
                                picdate: picdate.text)));
                  }
                },
                child: const Text(
                  'ถัดไป',
                  style: TextStyle(
                      color: Color.fromARGB(255, 45, 134, 156),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  primary: const Color.fromARGB(255, 255, 255, 255),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
