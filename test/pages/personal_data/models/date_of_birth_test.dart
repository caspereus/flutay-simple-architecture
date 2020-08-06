// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validDateOfBirthMock = "10-10-2001";
  group('Date of Birth', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final dateOfBirth = DateOfBirth.pure();
        expect(dateOfBirth.value, '');
        expect(dateOfBirth.pure, true);
      });

      test('dirty creates correct instance', () {
        final dateOfBirth = DateOfBirth.dirty(validDateOfBirthMock);
        expect(dateOfBirth.value, validDateOfBirthMock);
        expect(dateOfBirth.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when date of birth is empty', () {
        expect(
          DateOfBirth.dirty('').error,
          DateOfBirthValidatorError.EMPTY,
        );
      });

      test('is valid when date of birth is not empty',
          () {
        expect(
          DateOfBirth.dirty(validDateOfBirthMock).error,
          isNull,
        );
      });
    });
  });
}
