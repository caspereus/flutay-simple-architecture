import 'package:amar_bank_test/pages/personal_data/models/fullname.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const invalidFullNameMock = "I Putu Aldy Cahyakusuma";
  const validFullNameMock = "Putuu";

  group("Full Name", () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final fullName = FullName.pure();
        expect(fullName.value, '');
        expect(fullName.pure, true);
      });

      test('dirty creates correct instance', () {
        final fullName = FullName.dirty(invalidFullNameMock);
        expect(fullName.value, invalidFullNameMock);
        expect(fullName.pure, false);
      });
    });

    group('validator', () {
      test('returns not characters error when full name is not characters', () {
        expect(
          FullName.dirty("123").error,
          FullNameValidatorError.NOT_CHARACTERS,
        );
      });

      test('returns invalid length error when full name exceed the maximum characters', () {
        expect(
          FullName.dirty(invalidFullNameMock).error,
          FullNameValidatorError.LENGTH_NOT_VALID,
        );
      });

      test('is valid when full name is characters and a length of characters less than 10', () {
        expect(
          FullName.dirty(validFullNameMock).error,
          isNull,
        );
      });
    });
  });
}
