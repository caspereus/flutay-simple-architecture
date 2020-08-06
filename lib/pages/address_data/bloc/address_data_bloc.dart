import 'package:amar_bank_test/core/responses/province_response.dart';
import 'package:amar_bank_test/core/services/place_service.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_event.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_state.dart';
import 'package:amar_bank_test/pages/address_data/models/domicile_address.dart';
import 'package:amar_bank_test/pages/address_data/models/housing_type.dart';
import 'package:amar_bank_test/pages/address_data/models/no.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

class AddressDataBloc extends Bloc<AddressDataEvent, AddressDataState> {
  PlaceService _placeService;

  AddressDataBloc({@required PlaceService placeService})
      : assert(placeService != null),
        _placeService = placeService,
        super(AddressDataState());

  @override
  void onTransition(Transition<AddressDataEvent, AddressDataState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AddressDataState> mapEventToState(AddressDataEvent event) async* {
    if (event is AddressDataDomicileAddressChanged) {
      yield _mapDomicileAddressChangedToState(event, state);
    } else if (event is AddressDataHousingTypeChanged) {
      yield _mapHousingTypeChangedToState(event, state);
    } else if (event is AddressDataNoChanged) {
      yield _mapNoChangedToState(event, state);
    } else if (event is LoadDataProvinces) {
      yield* _mapLoadProvinceToState(event, state);
    } else if (event is AddressDataProvinceChanged) {
      yield _mapProvinceChangedToState(event, state);
    }
  }

  AddressDataState _mapDomicileAddressChangedToState(
    AddressDataDomicileAddressChanged event,
    AddressDataState state,
  ) {
    final domicileAddress = DomicileAddress.dirty(event.domicileAddress);
    return state.copyWith(
      domicileAddress: domicileAddress,
      status: Formz.validate([
        domicileAddress,
        state.housingType,
        state.no,
      ]),
    );
  }

  AddressDataState _mapProvinceChangedToState(
    AddressDataProvinceChanged event,
    AddressDataState state,
  ) {
    final province = event.province;
    return state.copyWith(
      province: province,
      status: Formz.validate([
        state.domicileAddress,
        state.housingType,
        state.no,
      ]),
    );
  }

  AddressDataState _mapHousingTypeChangedToState(
    AddressDataHousingTypeChanged event,
    AddressDataState state,
  ) {
    final housingType = HousingType.dirty(event.housingType);
    return state.copyWith(
      housingType: housingType,
      status: Formz.validate([
        state.domicileAddress,
        housingType,
        state.no,
      ]),
    );
  }

  AddressDataState _mapNoChangedToState(
    AddressDataNoChanged event,
    AddressDataState state,
  ) {
    final no = No.dirty(event.no);
    return state.copyWith(
      no: no,
      status: Formz.validate([
        state.domicileAddress,
        state.housingType,
        no,
      ]),
    );
  }

  Stream<AddressDataState> _mapLoadProvinceToState(
    LoadDataProvinces event,
    AddressDataState state,
  ) async* {
    yield state.copyWith(loadingState: LoadingState.loading);
    try {
      ProvinceResponse response = await _placeService.getProvinces();
      Future.delayed(Duration(seconds: 5));
      yield state.copyWith(
        loadingState: LoadingState.loaded,
        provinces: response.province,
        province: response.province.length > 0 ? response.province[0] : null,
      );
    } on Exception catch (_) {
      yield state.copyWith(loadingState: LoadingState.failed);
    }
  }
}
