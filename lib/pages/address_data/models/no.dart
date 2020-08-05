import 'package:formz/formz.dart';

enum NoValidatorError { EMPTY, NOT_NUMERIC }

class No extends FormzInput<String, NoValidatorError> {
  const No.pure() : super.pure('');

  const No.dirty([String value = '']) : super.dirty(value);

  @override
  NoValidatorError validator(String value) {
    if (value.isEmpty) return NoValidatorError.EMPTY;
    if (!_isNumeric(value)) return NoValidatorError.NOT_NUMERIC;
    return null;
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
