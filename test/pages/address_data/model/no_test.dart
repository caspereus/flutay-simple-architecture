// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/address_data/models/no.dart';
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const noMock = "1122334455667788";
  group('No', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final no = No.pure();
        expect(no.value, '');
        expect(no.pure, true);
      });

      test('dirty creates correct instance', () {
        final no = No.dirty(noMock);
        expect(no.value, noMock);
        expect(no.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when no is empty', () {
        expect(
          No.dirty('').error,
          NoValidatorError.EMPTY,
        );
      });

      test('returns not numeric error when no is not numeric', () {
        expect(
          No.dirty("ASD").error,
          NoValidatorError.NOT_NUMERIC,
        );
      });

      test('is valid when no is numeric,not empty', () {
        expect(
          No.dirty(noMock).error,
          isNull,
        );
      });
    });
  });
}
