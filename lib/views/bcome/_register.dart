import 'package:creative/models/textformfieldmodel.dart';
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
  late DateTime datenow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future newDate() async {
      DateTime? date = await showDatePicker(
          context: context,
          initialDate: datenow,
          firstDate: DateTime(DateTime.now().year - 70),
          lastDate: DateTime(DateTime.now().year, DateTime.now().day));

      date != null
          ? picdate.text = DateFormat("yyyy-MM-dd").format(date)
          : picdate.text = "";
    }

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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //username
                TextFieldRegis(
                  labeltext: 'Usename',
                  controller: username,
                  textEmpty: 'Please fill you Usename in the blank',
                ),
                const SizedBox(
                  height: 10,
                ),
                //รหัสผ่าน
                TextFieldRegis(
                  labeltext: 'password',
                  controller: password,
                  textEmpty: 'Password More 6 Charactor',
                ),
                const SizedBox(
                  height: 10,
                ),
                //ยืนยันรหัสผ่าน
                TextFieldRegis(
                  labeltext: 'confirm password',
                  controller: confirmpassword,
                  textEmpty: 'password not same',
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldRegis(
                        controller: name,
                        textEmpty: 'Please fill you name in the blank',
                        labeltext: 'Name',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextFieldRegis(
                        controller: surname,
                        textEmpty: 'Please fill you surname in the blank',
                        labeltext: 'surname',
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
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
                  keyboardType: TextInputType.text,

                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    labelText: 'date',
                    labelStyle: const TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    helperText: 'Tyep you date for display',
                    hintText: 'date',
                    hintStyle: const TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255)),
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
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    prefixIcon: const Icon(
                      Icons.date_range,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState?.save();
                    }
                    print(picdate.text);
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
