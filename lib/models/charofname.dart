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

typeWorkRevers(String i) {
  if (i == "เด็ก") {
    return "0";
  } else if (i == "ผู้ป่วย") {
    return "1";
  } else {
    return "2";
  }
}
