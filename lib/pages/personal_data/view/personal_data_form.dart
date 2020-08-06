import 'dart:developer';

import 'package:amar_bank_test/pages/address_data/view/address_data_page.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_bloc.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_event.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_state.dart';
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class PersonalDataForm extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocListener<PersonalDataBloc, PersonalDataState>(
      listener: (context, state) {
        log(state.status.toString());
        if (state.status == FormzStatus.submissionSuccess) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text('Successfully Submit Personal Data')),
            );
          Navigator.push(
            context,
            AddressDataPage.route(
              state.registrationData,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NationIDInput(),
            _buildSpacerInput(),
            _FullNameInput(),
            _buildSpacerInput(),
            _BankAccountNoInput(),
            _buildSpacerInput(),
            _EducationDropDown(),
            _buildSpacerInput(),
            _DateOfBirthDatePicker(),
            _buildSpacerInput(),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacerInput() {
    return const Padding(padding: EdgeInsets.all(12));
  }
}

class _NationIDInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      buildWhen: (previous, current) => previous.nationID != current.nationID,
      builder: (context, state) {
        return TextField(
          key: const Key('personalDataForm_nationIDInput_textField'),
          keyboardType: TextInputType.number,
          onChanged: (nationId) {
            context
                .bloc<PersonalDataBloc>()
                .add(PersonalDataNationIDChanged(nationId));
          },
          decoration: InputDecoration(
            labelText: 'Nation ID',
            errorText: state.nationID.invalid
                ? _getMessageError(state.nationID.error)
                : null,
          ),
        );
      },
    );
  }

  String _getMessageError(NationIDValidationError error) {
    switch (error) {
      case NationIDValidationError.EMPTY:
        return "field is empty";
        break;
      case NationIDValidationError.NOT_NUMERIC:
        return "field must be numeric";
        break;
      case NationIDValidationError.LENGTH_NOT_VALID:
        return "field must be 16 characters";
        break;
      default:
        return null;
    }
  }
}

class _FullNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return TextField(
          key: const Key('personalDataForm_fullNameInput_textField'),
          onChanged: (fullName) {
            context
                .bloc<PersonalDataBloc>()
                .add(PersonalDataFullNameChanged(fullName));
          },
          decoration: InputDecoration(
            labelText: 'Full Name',
            errorText: state.fullName.invalid
                ? _getMessageError(state.fullName.error)
                : null,
          ),
        );
      },
    );
  }

  String _getMessageError(FullNameValidatorError error) {
    switch (error) {
      case FullNameValidatorError.LENGTH_NOT_VALID:
        return "full name max 10 characters";
        break;
      case FullNameValidatorError.NOT_CHARACTERS:
        return "full name must be character not numeric";
        break;
      default:
        return null;
    }
  }
}

class _BankAccountNoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      buildWhen: (previous, current) =>
          previous.bankAccountNo != current.bankAccountNo,
      builder: (context, state) {
        return TextField(
          key: const Key('personalDataForm_BankAccountNo_textField'),
          keyboardType: TextInputType.number,
          onChanged: (bankAccountNo) {
            context
                .bloc<PersonalDataBloc>()
                .add(PersonalDataBankAccountNoChanged(bankAccountNo));
          },
          decoration: InputDecoration(
            labelText: 'Bank Account No',
            errorText: state.bankAccountNo.invalid
                ? _getMessageError(state.bankAccountNo.error)
                : null,
          ),
        );
      },
    );
  }

  String _getMessageError(BankAccountNoValidatorError error) {
    switch (error) {
      case BankAccountNoValidatorError.EMPTY:
        return "field is empty";
        break;
      case BankAccountNoValidatorError.LENGTH_NOT_VALID:
        return "field must be at least 8 characters";
        break;
      case BankAccountNoValidatorError.NOT_NUMERIC:
        return "field must be numeric";
        break;
      default:
        return null;
    }
  }
}

class _EducationDropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      buildWhen: (previous, current) => previous.education != current.education,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Please choose your city: "),
            Container(
              padding: new EdgeInsets.all(5.0),
            ),
            DropdownButton<String>(
                key: const Key('personalDataForm_educationDropdown'),
                value: state.education.value,
                isExpanded: true,
                items: state.education.educations
                    .map((String education) => DropdownMenuItem<String>(
                          value: education,
                          child: Text(education),
                        ))
                    .toList(),
                onChanged: (String education) {
                  context
                      .bloc<PersonalDataBloc>()
                      .add(PersonalDataEducationChanged(education));
                })
          ],
        );
      },
    );
  }
}

class _DateOfBirthDatePicker extends StatefulWidget {
  @override
  _DateOfBirthDatePickerState createState() => _DateOfBirthDatePickerState();
}

class _DateOfBirthDatePickerState extends State<_DateOfBirthDatePicker> {
  TextEditingController _dateOfBirthTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
      buildWhen: (previous, current) =>
          previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            DateTime datePicked = await _pickDate();
            if (datePicked != null) {
              String formattedDate = _formatDate(datePicked);
              _setTextFieldDate(formattedDate);
              context
                  .bloc<PersonalDataBloc>()
                  .add(PersonalDataDateOfBirthChanged(formattedDate));
            }
          },
          child: Container(
            color: Colors.transparent,
            child: TextField(
              key: const Key('personalDataForm_BankAccountNoInput_textField'),
              enabled: false,
              keyboardType: TextInputType.datetime,
              controller: _dateOfBirthTextFieldController,
              decoration: InputDecoration(
                labelText: 'Date Of Birth',
                errorText: state.dateOfBirth.invalid
                    ? _getMessageError(state.dateOfBirth.error)
                    : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<DateTime> _pickDate() async {
    final DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1995, 8),
      lastDate: DateTime.now(),
    );

    return datePicked;
  }

  String _formatDate(DateTime datePicked) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked);
    return formattedDate;
  }

  void _setTextFieldDate(String formattedDate) {
    _dateOfBirthTextFieldController.text = formattedDate;
  }

  String _getMessageError(DateOfBirthValidatorError error) {
    switch (error) {
      case DateOfBirthValidatorError.EMPTY:
        return "field is empty";
        break;
      default:
        return null;
    }
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDataBloc, PersonalDataState>(
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
                              .bloc<PersonalDataBloc>()
                              .add(PersonalDataSubmitted());
                        }
                      : null,
                ),
              );
      },
    );
  }
}
