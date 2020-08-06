import 'package:amar_bank_test/core/repositories/place_repository.dart';
import 'package:amar_bank_test/core/responses/province_response.dart';
import 'package:flutter/cupertino.dart';

class PlaceService {
  PlaceRepository _placeRepository;

  PlaceService({@required PlaceRepository placeRepository})
      : assert(placeRepository != null),
        _placeRepository = placeRepository;

  Future<ProvinceResponse> getProvinces() {
    return _placeRepository.getProvinces();
  }
}
