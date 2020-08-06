import 'package:amar_bank_test/core/models/province_model.dart';
import 'package:amar_bank_test/pages/address_data/models/domicile_address.dart';
import 'package:amar_bank_test/pages/address_data/models/housing_type.dart';
import 'package:amar_bank_test/pages/address_data/models/no.dart';
import 'package:flutter/cupertino.dart';

class AddressData {
  final DomicileAddress domicileAddress;
  final HousingType housingType;
  final No no;
  final ProvinceModel province;

  AddressData({
    @required this.domicileAddress,
    @required this.housingType,
    @required this.no,
    @required this.province,
  })  : assert(domicileAddress != null),
        assert(housingType != null),
        assert(no != null),
        assert(province != null);
}
