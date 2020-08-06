import 'package:formz/formz.dart';

class EducationEnum {
  static const SD = "SD";
  static const SMP = "SMP";
  static const SMA = "SMA";
  static const SMK = "SMK";
  static const S1 = "S1";
  static const S2 = "S2";
  static const S3 = "S3";

  static List<String> values = [SD, SMP, SMA, SMK, S1, S2, S3];
}

enum EducationValidatorError { EMPTY, INVALID_VALUE }

class Education extends FormzInput<String, EducationValidatorError> {
  const Education.pure() : super.pure(EducationEnum.SD);

  const Education.dirty([String value = '']) : super.dirty(value);

  List<String> get educations => EducationEnum.values;

  @override
  EducationValidatorError validator(String value) {
    if (value.isEmpty) return EducationValidatorError.EMPTY;
    if (!EducationEnum.values.contains(value))
      return EducationValidatorError.INVALID_VALUE;
    return null;
  }
}
