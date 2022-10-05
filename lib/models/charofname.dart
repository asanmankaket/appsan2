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
