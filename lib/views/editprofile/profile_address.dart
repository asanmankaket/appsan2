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

    widget.data['tambons'] != null
        ? tambons.text = widget.data['tambons']
        : tambons.text = "";
    widget.data['amphures'] != null
        ? tambons.text = widget.data['amphures']
        : tambons.text = "";
    widget.data['provinces'] != null
        ? tambons.text = widget.data['provinces']
        : tambons.text = "";
    widget.data['geographies'] != null
        ? tambons.text = widget.data['geographies']
        : tambons.text = "";
    widget.data['pincode'] != null
        ? tambons.text = widget.data['pincode']
        : tambons.text = "";
    widget.data['id_am'] != null
        ? tambons.text = widget.data['id_am']
        : tambons.text = "";
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
          TextFormFieldModel2(labelText: 'address', controller: geographies),
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
                widget.data['id_am']
                    ? sendDataProfile5(
                        tambons.text,
                        amphures.text,
                        provinces.text,
                        geographies.text,
                        pincode.text,
                        idaddress,
                        context)
                    : addDataProfile(
                        tambons.text,
                        amphures.text,
                        provinces.text,
                        geographies.text,
                        pincode.text,
                        idaddress,
                        context);
              },
              child: const Text('ยืนยันการแก้ไข'))
        ])),
      ),
    );
  }
}
