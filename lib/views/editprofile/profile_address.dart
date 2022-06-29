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
        backgroundColor: const Color.fromARGB(255, 45, 134, 156),
      ),
      body: SizedBox(
          child: Column(children: [
        const SizedBox(height: 15),
        TextFormFieldModel2(
          labelText: 'address',
          controller: pincode,
        ),
        TextFormFieldModel2(labelText: 'address', controller: geographies),
        TextFormFieldModel2(
          labelText: 'address',
          controller: provinces,
        ),
        TextFormFieldModel2(
          labelText: 'address',
          controller: amphures,
        ),
        TextFormFieldModel2(
          labelText: 'address',
          controller: tambons,
        ),
        TextButton(
            onPressed: () {
              sendDataProfile5(tambons.text, amphures.text, provinces.text,
                  geographies.text, pincode.text, idaddress, context);
            },
            child: const Text('ยืนยันการแก้ไข'))
      ])),
    );
  }
}
