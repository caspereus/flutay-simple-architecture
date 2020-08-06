import 'package:formz/formz.dart';

class HousingTypeEnum {
  static const OFFICE = "Kantor";
  static const HOME = "Rumah";

  static List<String> values = [OFFICE, HOME];
}

enum HousingTypeValidatorError { EMPTY, INVALID_VALUE }

class HousingType extends FormzInput<String, HousingTypeValidatorError> {
  const HousingType.pure() : super.pure(HousingTypeEnum.HOME);

  const HousingType.dirty([String value = '']) : super.dirty(value);

  List<String> get types => HousingTypeEnum.values;

  @override
  HousingTypeValidatorError validator(String value) {
    if (value.isEmpty) return HousingTypeValidatorError.EMPTY;
    if (!HousingTypeEnum.values.contains(value))
      return HousingTypeValidatorError.INVALID_VALUE;
    return null;
  }
}
