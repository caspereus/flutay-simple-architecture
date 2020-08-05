import 'dart:convert';

import 'package:amar_bank_test/core/models/province.dart';

ProvinceResponse provinceResponseFromJson(String str) =>
    ProvinceResponse.fromJson(json.decode(str));

String provinceResponseToJson(ProvinceResponse data) =>
    json.encode(data.toJson());

class ProvinceResponse {
  ProvinceResponse({
    this.province,
  });

  List<Province> province;

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        province: json["provinsi"] == null
            ? null
            : List<Province>.from(
                json["provinsi"].map((x) => Province.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "provinsi": province == null
            ? null
            : List<dynamic>.from(province.map((x) => x.toJson())),
      };
}
