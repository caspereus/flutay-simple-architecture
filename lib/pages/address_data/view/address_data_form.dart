import 'dart:developer';

import 'package:amar_bank_test/core/dto/registration_data.dart';
import 'package:amar_bank_test/core/models/province_model.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_bloc.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_event.dart';
import 'package:amar_bank_test/pages/address_data/bloc/address_data_state.dart';
import 'package:amar_bank_test/pages/address_data/models/domicile_address.dart';
import 'package:amar_bank_test/pages/address_data/models/no.dart';
import 'package:amar_bank_test/pages/review_data/view/review_data_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddressDataForm extends StatelessWidget {
  final AddressDataBloc _bloc;
  final RegistrationData _registrationData;

  AddressDataForm(
      {@required AddressDataBloc bloc,
      @required RegistrationData registrationData})
      : assert(bloc != null),
        assert(registrationData != null),
        _bloc = bloc,
        _registrationData = registrationData;

  Widget build(BuildContext context) {
    _bloc.add(SetRegistrationData(_registrationData));
    _bloc.add(LoadDataProvinces());

    return BlocListener<AddressDataBloc, AddressDataState>(
      listener: (context, state) {
        log("Current Provinces ${state.province.name}");
        if (state.status == FormzStatus.submissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Successfully Submit Address Data')),
            );
          Navigator.push(context, ReviewDataPage.route(state.registrationData));
        }
      },
      child: BlocBuilder<AddressDataBloc, AddressDataState>(
        buildWhen: (previous, current) =>
            previous.loadingState != current.loadingState,
        builder: (context, state) => LoadingOverlay(
          isLoading: state.loadingState == LoadingState.loading,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DomicileAddressInput(),
                _buildSpacerInput(),
                _HousingTypeDropDown(),
                _buildSpacerInput(),
                _NoInput(),
                _buildSpacerInput(),
                _ProvinceDropDown(),
                _buildSpacerInput(),
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpacerInput() {
    return const Padding(padding: EdgeInsets.all(12));
  }
}

class _DomicileAddressInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressDataBloc, AddressDataState>(
      buildWhen: (previous, current) =>
          previous.domicileAddress != current.domicileAddress,
      builder: (context, state) {
        return TextField(
          key: const Key('address_data_form_domicile_address_input'),
          keyboardType: TextInputType.text,
          onChanged: (domicileAddress) {
            context
                .bloc<AddressDataBloc>()
                .add(AddressDataDomicileAddressChanged(domicileAddress));
          },
          decoration: InputDecoration(
            labelText: 'Domicile Address',
            errorText: state.domicileAddress.invalid
                ? _getMessageError(state.domicileAddress.error)
                : null,
          ),
        );
      },
    );
  }

  String _getMessageError(DomicileAddressValidatorError error) {
    switch (error) {
      case DomicileAddressValidatorError.LENGTH_NOT_VALID:
        return "maximum characters is 100";
        break;
      case DomicileAddressValidatorError.EMPTY:
        return "field is empty";
        break;
      default:
        return null;
    }
  }
}

class _HousingTypeDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressDataBloc, AddressDataState>(
      buildWhen: (previous, current) =>
          previous.housingType != current.housingType,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Please choose your Housing Type: "),
            Container(
              padding: new EdgeInsets.all(5.0),
            ),
            DropdownButton<String>(
                value: state.housingType.value,
                isExpanded: true,
                items: state.housingType.types
                    .map((String housingType) => DropdownMenuItem<String>(
                          value: housingType,
                          child: Text(housingType),
                        ))
                    .toList(),
                onChanged: (String housingType) {
                  context
                      .bloc<AddressDataBloc>()
                      .add(AddressDataHousingTypeChanged(housingType));
                })
          ],
        );
      },
    );
  }
}

class _NoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressDataBloc, AddressDataState>(
      buildWhen: (previous, current) => previous.no != current.no,
      builder: (context, state) {
        return TextField(
          key: const Key('address_data_form_no_input'),
          keyboardType: TextInputType.number,
          onChanged: (no) {
            context.bloc<AddressDataBloc>().add(AddressDataNoChanged(no));
          },
          decoration: InputDecoration(
            labelText: 'No',
            errorText:
                state.no.invalid ? _getMessageError(state.no.error) : null,
          ),
        );
      },
    );
  }

  String _getMessageError(NoValidatorError error) {
    switch (error) {
      case NoValidatorError.NOT_NUMERIC:
        return "field must be numeric";
        break;
      case NoValidatorError.EMPTY:
        return "field is empty";
        break;
      default:
        return null;
    }
  }
}

class _ProvinceDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressDataBloc, AddressDataState>(
      buildWhen: (previous, current) => previous.province != current.province,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Please choose your Province: "),
            Container(
              padding: new EdgeInsets.all(5.0),
            ),
            DropdownButton<ProvinceModel>(
                value: state.province,
                isExpanded: true,
                items: state.provinces.length > 0
                    ? state.provinces
                        .map((ProvinceModel province) =>
                            DropdownMenuItem<ProvinceModel>(
                              value: province,
                              child: Text(province.name),
                            ))
                        .toList()
                    : [],
                onChanged: (ProvinceModel province) {
                  context
                      .bloc<AddressDataBloc>()
                      .add(AddressDataProvinceChanged(province));
                })
          ],
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressDataBloc, AddressDataState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                width: double.infinity,
                height: 60,
                child: RaisedButton(
                  key: const Key('submitButton_continue_raisedButton'),
                  child: const Text('Submit'),
                  onPressed: state.status.isValidated
                      ? () {
                          context
                              .bloc<AddressDataBloc>()
                              .add(AddressDataSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
