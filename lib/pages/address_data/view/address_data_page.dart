import 'package:amar_bank_test/core/di/locator.dart';
import 'package:amar_bank_test/core/dto/registration_data.dart';
import 'package:amar_bank_test/core/services/place_service.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_bloc.dart';
import 'package:amar_bank_test/pages/address_data/view/address_data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDataPage extends StatelessWidget {
  final RegistrationData _registrationData;

  AddressDataPage({@required RegistrationData registrationData})
      : assert(registrationData != null),
        _registrationData = registrationData;

  static Route route(RegistrationData registrationData) {
    return MaterialPageRoute<void>(
      builder: (_) => AddressDataPage(
        registrationData: registrationData,
      ),
    );
  }

  // ignore: close_sinks
  final AddressDataBloc _bloc = AddressDataBloc(
    placeService: locator<PlaceService>(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Data"),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: AddressDataForm(
          bloc: _bloc,
        ),
      ),
    );
  }
}
