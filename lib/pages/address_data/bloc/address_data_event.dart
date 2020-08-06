import 'package:amar_bank_test/core/models/province_model.dart';
import 'package:equatable/equatable.dart';

abstract class AddressDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddressDataDomicileAddressChanged extends AddressDataEvent {
  AddressDataDomicileAddressChanged(this.domicileAddress);

  final String domicileAddress;

  @override
  List<Object> get props => [domicileAddress];
}

class AddressDataHousingTypeChanged extends AddressDataEvent {
  AddressDataHousingTypeChanged(this.housingType);

  final String housingType;

  @override
  List<Object> get props => [housingType];
}

class AddressDataNoChanged extends AddressDataEvent {
  AddressDataNoChanged(this.no);

  final String no;

  @override
  List<Object> get props => [no];
}

class AddressDataProvinceChanged extends AddressDataEvent {
  AddressDataProvinceChanged(this.province);

  final ProvinceModel province;

  @override
  List<Object> get props => [province];
}

class AddressDataSubmitted extends AddressDataEvent {}

class LoadDataProvinces extends AddressDataEvent {}
