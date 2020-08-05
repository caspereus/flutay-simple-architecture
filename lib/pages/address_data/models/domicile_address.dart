import 'package:formz/formz.dart';

enum DomicileAddressValidatorError { LENGTH_NOT_VALID, EMPTY }

class DomicileAddress
    extends FormzInput<String, DomicileAddressValidatorError> {
  const DomicileAddress.pure() : super.pure('');

  const DomicileAddress.dirty([String value = '']) : super.dirty(value);

  static const MAX_CHARACTER_LENGTH = 100;

  @override
  DomicileAddressValidatorError validator(String value) {
    if (value.isEmpty) return DomicileAddressValidatorError.EMPTY;
    if (value.isNotEmpty && value.length >= MAX_CHARACTER_LENGTH)
      return DomicileAddressValidatorError.LENGTH_NOT_VALID;
    return null;
  }
}
