// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const nationIdMock = "1122334455667788";
  group('Nation ID', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final nationId = NationID.pure();
        expect(nationId.value, '');
        expect(nationId.pure, true);
      });

      test('dirty creates correct instance', () {
        final nationId = NationID.dirty(nationIdMock);
        expect(nationId.value, nationIdMock);
        expect(nationId.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when nation id is empty', () {
        expect(
          NationID.dirty('').error,
          NationIDValidationError.EMPTY,
        );
      });

      test('returns not numeric error when nation id is not numeric', () {
        expect(
          NationID.dirty("ASD").error,
          NationIDValidationError.NOT_NUMERIC,
        );
      });

      test('is valid when nation id is numeric,not empty & char length is 16', () {
        expect(
          NationID.dirty(nationIdMock).error,
          isNull,
        );
      });
    });
  });
}
