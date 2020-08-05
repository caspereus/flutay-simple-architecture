import 'package:formz/formz.dart';

enum NationIDValidationError { EMPTY, NOT_NUMERIC , LENGTH_NOT_VALID }

class NationID extends FormzInput<String, NationIDValidationError> {
  const NationID.pure() : super.pure('');
  const NationID.dirty([String value = '']) : super.dirty(value);

  static const MINIMUM_CHAR_LENGTH = 16;

  @override
  NationIDValidationError validator(String value) {
    if(value.isEmpty) return NationIDValidationError.EMPTY;
    if(!_isNumeric(value)) return NationIDValidationError.NOT_NUMERIC;
    if(value.length != MINIMUM_CHAR_LENGTH) return NationIDValidationError.LENGTH_NOT_VALID;
    return null;

  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
