import 'dart:convert';

ProvinceModel provinceFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {


  ProvinceModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json["id"] == null ? null : json["id"],
        name: json["nama"] == null ? null : json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama": name == null ? null : name,
      };
}
