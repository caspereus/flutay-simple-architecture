import 'package:formz/formz.dart';

enum FullNameValidatorError { LENGTH_NOT_VALID, NOT_NUMERIC }

class FullName extends FormzInput<String, FullNameValidatorError> {
  const FullName.pure() : super.pure('');

  const FullName.dirty([String value = '']) : super.dirty(value);

  static const MAX_CHARACTER_LENGTH = 10;

  @override
  FullNameValidatorError validator(String value) {
    if (value.isNotEmpty && _isNumeric(value))
      return FullNameValidatorError.NOT_NUMERIC;
    if (value.isNotEmpty && value.length >= MAX_CHARACTER_LENGTH)
      return FullNameValidatorError.LENGTH_NOT_VALID;
    return null;
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
