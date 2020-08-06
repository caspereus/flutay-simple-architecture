import 'package:amar_bank_test/core/models/province_model.dart';
import 'package:amar_bank_test/pages/address_data/models/domicile_address.dart';
import 'package:amar_bank_test/pages/address_data/models/housing_type.dart';
import 'package:amar_bank_test/pages/address_data/models/no.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

enum LoadingState { idle, loading, loaded, failed }

class AddressDataState extends Equatable {
  const AddressDataState({
    this.status = FormzStatus.pure,
    this.domicileAddress = const DomicileAddress.pure(),
    this.housingType = const HousingType.pure(),
    this.no = const No.pure(),
    this.provinces = const [],
    this.province,
    this.loadingState = LoadingState.idle,
  });

  final FormzStatus status;
  final DomicileAddress domicileAddress;
  final HousingType housingType;
  final No no;
  final List<ProvinceModel> provinces;
  final LoadingState loadingState;
  final ProvinceModel province;

  AddressDataState copyWith({
    FormzStatus status,
    DomicileAddress domicileAddress,
    HousingType housingType,
    No no,
    List<ProvinceModel> provinces,
    LoadingState loadingState,
    ProvinceModel province,
  }) {
    return new AddressDataState(
      status: status ?? this.status,
      domicileAddress: domicileAddress ?? this.domicileAddress,
      housingType: housingType ?? this.housingType,
      no: no ?? this.no,
      provinces: provinces ?? this.provinces,
      loadingState: loadingState ?? this.loadingState,
      province: province ?? this.province,
    );
  }

  @override
  List<Object> get props => [
        status,
        domicileAddress,
        housingType,
        no,
        provinces,
        loadingState,
        province
      ];

  @override
  bool get stringify => true;
}
