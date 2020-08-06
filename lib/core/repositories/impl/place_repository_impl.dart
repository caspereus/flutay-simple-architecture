import 'dart:convert';

import 'package:amar_bank_test/core/network/api.dart';
import 'package:amar_bank_test/core/repositories/place_repository.dart';
import 'package:amar_bank_test/core/responses/province_response.dart';
import 'package:flutter/cupertino.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  Api _api;

  PlaceRepositoryImpl({@required Api api})
      : assert(api != null),
        _api = api;

  @override
  Future<ProvinceResponse> getProvinces() async {
    final res = await _api.get(url: "daerahindonesia/provinsi");
    final resDecoded = jsonDecode(res);
    return ProvinceResponse.fromJson(resDecoded);
  }
}
