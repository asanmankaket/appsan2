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
  int? idaddress, idProvinces, idAmphures, idTambons;
  String? nameTambons, nameAmphures, nameProvinces;
  int? provinceValue, amphureValue, tambonValue;

  @override
  void initState() {
    super.initState();
    widget.data['men_tambons'] != null
        ? nameTambons = widget.data['men_tambons']
        : provinceValue = 1;
    widget.data['men_amphures'] != null
        ? nameAmphures = widget.data['men_amphures']
        : amphureValue = null;
    widget.data['men_provinces'] != null
        ? nameProvinces = widget.data['men_provinces']
        : tambonValue = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('แก้ไขสถานที่'),
          backgroundColor: const Color.fromARGB(255, 76, 124, 172),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: 390,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid)),
                child: FutureBuilder(
                  future: readJsonDataProvinces(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var items = data.data as List<Provinces>;
                      // return DropdownButton(items: , onChanged: onChanged)
                      if (widget.data['men_provinces'] != null) {
                        var item1 = items.singleWhere(
                            (element) => element.nameTh == nameProvinces);
                        provinceValue = item1.id;
                      }
                      return DropdownButton(
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          isExpanded: true,
                          value: provinceValue,
                          items: items.map((value) {
                            return DropdownMenuItem(
                                child: Text(value.nameTh.toString()),
                                value: value.id);
                          }).toList(),
                          onChanged: (index) {
                            setState(() {
                              provinceValue = index as int;
                              amphureValue = null;
                            });
                            var select = items.singleWhere(
                                (element) => element.id == index as int);
                            nameProvinces = select.nameTh;
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 390,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid)),
                child: FutureBuilder(
                  future: readJsonDataAmphures(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var itemsdata = data.data as List<Amphures>;
                      dynamic itemdatabase;
                      if (widget.data['men_amphures'] != null) {
                        itemdatabase = itemsdata.singleWhere(
                            (element) => element.nameTh == nameAmphures);
                      }
                      var items = itemsdata.where(
                          (element) => element.provinceId == provinceValue);

                      if (items.contains(itemdatabase)) {
                        amphureValue = itemdatabase.id;
                      } else {
                        amphureValue = items.first.id;
                      }
                      return DropdownButton(
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          isExpanded: true,
                          value: amphureValue,
                          items: items.map((value) {
                            return DropdownMenuItem(
                                child: Text(value.nameTh), value: value.id);
                          }).toList(),
                          onChanged: (index) {
                            setState(() {
                              amphureValue = index as int;
                              tambonValue = null;
                            });
                            var select = items.singleWhere(
                                (element) => element.id == index as int);
                            nameAmphures = select.nameTh;
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 390,
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid)),
                child: FutureBuilder(
                  future: readJsonDataTambons(),
                  builder: (context, data) {
                    if (data.hasError) {
                      return Center(child: Text("${data.error}"));
                    } else if (data.hasData) {
                      var itemsdata = data.data as List<Tambons>;
                      var items = itemsdata.where(
                          (element) => element.amphureId == amphureValue);
                      dynamic itemdatabase;
                      if (widget.data['men_tambons'] != null) {
                        itemdatabase = itemsdata.singleWhere(
                            (element) => element.nameTh == nameTambons);
                      }
                      if (items.contains(itemdatabase)) {
                        tambonValue = itemdatabase.id;
                      } else {
                        tambonValue = items.first.id;
                      }
                      return DropdownButton(
                          underline:
                              DropdownButtonHideUnderline(child: Container()),
                          isExpanded: true,
                          value: tambonValue,
                          items: items.map((value) {
                            return DropdownMenuItem(
                                child: Text(value.nameTh), value: value.id);
                          }).toList(),
                          onChanged: (index) {
                            setState(() {
                              tambonValue = index as int;
                            });
                            var select = items.singleWhere(
                                (element) => element.id == index as int);
                            nameTambons = select.nameTh;
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  sendDataProfile5(
                      nameTambons, nameAmphures, nameProvinces, context);
                },
                child: Wrap(
                  children: const <Widget>[
                    Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(width: 10),
                    Text("บันทึก",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  primary: const Color.fromARGB(255, 76, 124, 172),
                ),
              )
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
