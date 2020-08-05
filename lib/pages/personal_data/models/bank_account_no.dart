import 'package:formz/formz.dart';

enum BankAccountNoValidatorError { EMPTY, LENGTH_NOT_VALID, NOT_NUMERIC }

class BankAccountNo extends FormzInput<String, BankAccountNoValidatorError> {
  const BankAccountNo.pure() : super.pure('');

  const BankAccountNo.dirty([String value = '']) : super.dirty(value);

  static const MINIMUM_CHAR_LENGTH = 8;

  @override
  BankAccountNoValidatorError validator(String value) {
    if (value.isEmpty) return BankAccountNoValidatorError.EMPTY;
    if (!_isNumeric(value)) return BankAccountNoValidatorError.NOT_NUMERIC;
    if (value.length <= MINIMUM_CHAR_LENGTH) return BankAccountNoValidatorError.LENGTH_NOT_VALID;
    return null;
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
