import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typeWork(int i) {
  switch (i) {
    case 0:
      return "ดูแลเด็ก";
    case 1:
      return "ดูแลผู้สูงอายุ";
    case 2:
      return "ดูแลผู้ป่วย";
  }
}

checkIdCard(citizenId) {
  String idcard = citizenId;
  int total = 0;
  for (int i = 0, sum = 0; i < 12; i++) {
    sum += int.parse(idcard[i]) * (13 - i);
    total = sum;
  }
  if ((11 - total % 11) % 10 != int.parse(idcard[12])) {
    return false;
  } else {
    return true;
  }
}

typeIcon(String i) {
  switch (i) {
    case "0":
      return Icon(
        Icons.child_friendly_outlined,
        color: Colors.pink[400],
        size: 30,
      );
    case "1":
      return const Icon(
        MdiIcons.humanCane,
        color: Colors.green,
        size: 33,
      );
    case "2":
      return const Icon(
        Icons.accessible,
        color: Colors.blue,
        size: 30,
      );
  }
}
