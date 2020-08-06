import 'package:amar_bank_test/core/responses/province_response.dart';

abstract class PlaceRepository {
  Future<ProvinceResponse> getProvinces();
}
