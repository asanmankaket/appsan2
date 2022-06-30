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

  TextEditingController pincode = TextEditingController();
  dynamic idaddress;
  @override
  void initState() {
    super.initState();

    widget.data['tambons'] != null
        ? tambons.text = widget.data['tambons']
        : tambons.text = "";
    widget.data['amphures'] != null
        ? amphures.text = widget.data['amphures']
        : amphures.text = "";
    widget.data['provinces'] != null
        ? provinces.text = widget.data['provinces']
        : provinces.text = "";
    widget.data['pincode'] != null
        ? pincode.text = widget.data['pincode']
        : pincode.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
            child: Column(children: [
          const SizedBox(height: 15),
          TextFormFieldModel2(
            labelText: 'รหัสไปรษณี',
            controller: pincode,
          ),
          TextFormFieldModel2(
            labelText: 'จังหวัด',
            controller: provinces,
          ),
          TextFormFieldModel2(
            labelText: 'อำเภอ',
            controller: amphures,
          ),
          TextFormFieldModel2(
            labelText: 'ตำบล',
            controller: tambons,
          ),
          TextButton(
              onPressed: () {
                sendDataProfile5(tambons.text, amphures.text, provinces.text,
                    pincode.text, context);
              },
              child: const Text('ยืนยันการแก้ไข'))
        ])),
      ),
    );
  }
}
