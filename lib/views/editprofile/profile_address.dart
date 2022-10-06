import 'dart:convert';
import 'package:creative/configs/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../configs/jsonprovinces.dart';

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
  dynamic idaddress,
      nameProvinces,
      idProvinces,
      nameAmphures,
      idAmphures,
      idTambons,
      nameTambons;

  @override
  void initState() {
    super.initState();

    widget.data['men_tambons'] != null
        ? tambons.text = widget.data['men_tambons']
        : tambons.text = "";
    widget.data['men_amphures'] != null
        ? amphures.text = widget.data['men_amphures']
        : amphures.text = "";
    widget.data['men_provinces'] != null
        ? provinces.text = widget.data['men_provinces']
        : provinces.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แก้ไขสถานที่'),
          backgroundColor: const Color.fromARGB(255, 160, 42, 207),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              FutureBuilder(
                future: readJsonDataProvinces(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var items = data.data as List<Provinces>;
                    // return DropdownButton(items: , onChanged: onChanged)
                    return DropdownButton(
                        items: items.map((value) {
                          return DropdownMenuItem(
                              child: Text(value.nameTh.toString()),
                              value: [value.nameTh, value.id]);
                        }).toList(),
                        onChanged: (index) {
                          setState(() {
                            List itemindex = index as List;
                            nameProvinces = itemindex[0];
                            idProvinces = itemindex[1];
                            print(nameProvinces);
                          });
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: readJsonDataAmphures(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var itemsdata = data.data as List<Amphures>;
                    var items = itemsdata
                        .where((element) => element.provinceId == idProvinces);

                    return DropdownButton(
                        items: items.map((value) {
                          return DropdownMenuItem(
                              child: Text(value.nameTh),
                              value: [value.nameTh, value.id]);
                        }).toList(),
                        onChanged: (index) {
                          setState(() {
                            List itemindex = index as List;
                            nameAmphures = itemindex[0];
                            idAmphures = itemindex[1];
                            print(nameAmphures);
                          });
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: readJsonDataTambons(),
                builder: (context, data) {
                  if (data.hasError) {
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    var itemsdata = data.data as List<Tambons>;
                    var items = itemsdata
                        .where((element) => element.amphureId == idAmphures);
                    return DropdownButton(
                        items: items.map((value) {
                          return DropdownMenuItem(
                              child: Text(value.nameTh),
                              value: [value.nameTh, value.id]);
                        }).toList(),
                        onChanged: (index) {
                          setState(() {
                            List itemindex = index as List;
                            nameTambons = itemindex[0];
                            idTambons = itemindex[1];
                            print(nameTambons);
                          });
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              TextButton(
                  onPressed: () {
                    sendDataProfile5(
                        nameTambons, nameAmphures, nameProvinces, context);
                  },
                  child: const SizedBox(
                    child: Text('บันทึก'),
                  ))
            ],
          ),
        ));
  }
}

// DropdownMenuItem(child: Text(items[index].nameTh),)
Future<List<Provinces>> readJsonDataProvinces() async {
  //read json file
  final jsondataprovince =
      await rootBundle.loadString('assets/json/thai_provinces.json');
  final listprovinces = json.decode(jsondataprovince) as List<dynamic>;
  return listprovinces.map((e) => Provinces.fromJson(e)).toList();
}

Future<List<Amphures>> readJsonDataAmphures() async {
  final jsondataamphures =
      await rootBundle.loadString('assets/json/thai_amphures.json');
  final listamphures = json.decode(jsondataamphures) as List<dynamic>;
  return listamphures.map((e) => Amphures.fromJson(e)).toList();
}

Future<List<Tambons>> readJsonDataTambons() async {
  final jsondatatambons =
      await rootBundle.loadString('assets/json/thai_tambons.json');
  final listtambons = json.decode(jsondatatambons) as List<dynamic>;
  return listtambons.map((e) => Tambons.fromJson(e)).toList();
}
