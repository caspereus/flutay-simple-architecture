import 'package:formz/formz.dart';

enum DateOfBirthValidatorError { EMPTY }

class DateOfBirth extends FormzInput<String, DateOfBirthValidatorError> {
  const DateOfBirth.pure() : super.pure('');

  const DateOfBirth.dirty([String value = '']) : super.dirty(value);

  @override
  DateOfBirthValidatorError validator(String value) {
    if (value.isEmpty) return DateOfBirthValidatorError.EMPTY;
    return null;
  }
}
