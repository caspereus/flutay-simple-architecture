// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/address_data/models/housing_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const invalidHousingTypeMock = "KEJAR";
  const validHousingTypeMock = HousingTypeEnum.HOME;
  group('Housing Type', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final housingType = HousingType.pure();
        expect(housingType.value, HousingTypeEnum.HOME);
        expect(housingType.pure, true);
      });

      test('dirty creates correct instance', () {
        final housingType = HousingType.dirty(validHousingTypeMock);
        expect(housingType.value, validHousingTypeMock);
        expect(housingType.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when housingType is empty', () {
        expect(
          HousingType.dirty('').error,
          HousingTypeValidatorError.EMPTY,
        );
      });

      test(
          'returns invalid value error when housingType is not in HousingTypeEnum values',
          () {
        expect(
          HousingType.dirty(invalidHousingTypeMock).error,
          HousingTypeValidatorError.INVALID_VALUE,
        );
      });

      test('is valid when housingType is not empty & value in housingType enum',
          () {
        expect(
          HousingType.dirty(validHousingTypeMock).error,
          isNull,
        );
      });
    });
  });
}
