// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../configs/api.dart';
import '../../models/textformfieldmodel.dart';

class ProfileAddress extends StatefulWidget {
  const ProfileAddress({Key? key, required this.data}) : super(key: key);
  final dynamic data;
  @override
  State<ProfileAddress> createState() => _ProfileAddressState();
}

class _ProfileAddressState extends State<ProfileAddress> {
  TextEditingController tambons = TextEditingController();
  TextEditingController amphures = TextEditingController();
  TextEditingController provinces = TextEditingController();
  TextEditingController geographies = TextEditingController();
  TextEditingController pincode = TextEditingController();
  dynamic idaddress;
  @override
  void initState() {
    super.initState();

    tambons.text = widget.data['tambons'];
    amphures.text = widget.data['amphures'];
    provinces.text = widget.data['provinces'];
    geographies.text = widget.data['geographies'];
    pincode.text = widget.data['pincode'];
    idaddress = widget.data['id_am'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เเก้ไขที่อยู่'),
        backgroundColor: const Color.fromARGB(255, 160, 42, 207),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
              child: Column(children: [
            const SizedBox(height: 15),
            TextFormFieldModel2(
              labelText: 'ตำบล',
              controller: tambons,
            ),
            TextFormFieldModel2(
              labelText: 'อำเภอ',
              controller: amphures,
            ),
            TextFormFieldModel2(
              labelText: 'จังหวัด',
              controller: provinces,
            ),
            TextFormFieldModel2(
              labelText: 'รหัสไปรษณี',
              controller: pincode,
            ),
            TextFormFieldModel2(labelText: 'ภูมิภาค', controller: geographies),
            ElevatedButton(
              onPressed: () {
                sendDataProfile5(tambons.text, amphures.text, provinces.text,
                    geographies.text, pincode.text, idaddress, context);
              },
              child: Wrap(
                children: <Widget>[
                  Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("บันทึก",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.symmetric(horizontal: 20),
                primary: Colors.purple,
              ),
            ),
          ])),
        ),
      ),
    );
  }
}
