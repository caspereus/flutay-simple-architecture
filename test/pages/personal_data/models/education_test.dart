// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const invalidEducationMock = "1122334455667788";
  const validEducationMock = EducationEnum.SMA;
  group('Education', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final education = Education.pure();
        expect(education.value, EducationEnum.SD);
        expect(education.pure, true);
      });

      test('dirty creates correct instance', () {
        final education = Education.dirty(validEducationMock);
        expect(education.value, validEducationMock);
        expect(education.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when education is empty', () {
        expect(
          Education.dirty('').error,
          EducationValidatorError.EMPTY,
        );
      });

      test(
          'returns invalid value error when education is not in EducationEnum values',
          () {
        expect(
          Education.dirty(invalidEducationMock).error,
          EducationValidatorError.INVALID_VALUE,
        );
      });

      test('is valid when education is not empty & value in education enum',
          () {
        expect(
          Education.dirty(validEducationMock).error,
          isNull,
        );
      });
    });
  });
}
