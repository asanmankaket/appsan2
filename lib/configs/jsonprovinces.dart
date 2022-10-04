import 'dart:convert';

List<Provinces> provincesFromJson(String str) =>
    List<Provinces>.from(json.decode(str).map((x) => Provinces.fromJson(x)));

String provincesToJson(List<Provinces> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provinces {
  Provinces({
    required this.id,
    required this.nameTh,
    required this.nameEn,
  });

  int id;
  String nameTh;
  String nameEn;

  factory Provinces.fromJson(Map<String, dynamic> json) => Provinces(
        id: json["id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_th": nameTh,
        "name_en": nameEn,
      };
}

List<Amphures> amphuresFromJson(String str) =>
    List<Amphures>.from(json.decode(str).map((x) => Amphures.fromJson(x)));

String amphuresToJson(List<Amphures> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Amphures {
  Amphures({
    required this.id,
    required this.nameTh,
    required this.nameEn,
    required this.provinceId,
  });

  int id;
  String nameTh;
  String nameEn;
  int provinceId;

  factory Amphures.fromJson(Map<String, dynamic> json) => Amphures(
        id: json["id"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        provinceId: json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_th": nameTh,
        "name_en": nameEn,
        "province_id": provinceId,
      };
}

List<Tambons> tambonsFromJson(String str) =>
    List<Tambons>.from(json.decode(str).map((x) => Tambons.fromJson(x)));

String tambonsToJson(List<Tambons> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tambons {
  Tambons({
    required this.id,
    required this.zipCode,
    required this.nameTh,
    required this.nameEn,
    required this.amphureId,
  });

  int id;
  int zipCode;
  String nameTh;
  String nameEn;
  int amphureId;

  factory Tambons.fromJson(Map<String, dynamic> json) => Tambons(
        id: json["id"],
        zipCode: json["zip_code"],
        nameTh: json["name_th"],
        nameEn: json["name_en"],
        amphureId: json["amphure_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zip_code": zipCode,
        "name_th": nameTh,
        "name_en": nameEn,
        "amphure_id": amphureId,
      };
}
