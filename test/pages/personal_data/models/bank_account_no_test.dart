import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const invalidBankAccountMock = "123123";
  const validBankAccountMock = "112233445566";

  group("Bank Account No", () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final bankAccountNo = BankAccountNo.pure();
        expect(bankAccountNo.value, '');
        expect(bankAccountNo.pure, true);
      });

      test('dirty creates correct instance', () {
        final bankAccountNo = BankAccountNo.dirty(invalidBankAccountMock);
        expect(bankAccountNo.value, invalidBankAccountMock);
        expect(bankAccountNo.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when bank account no is empty', () {
        expect(
          BankAccountNo.dirty('').error,
          BankAccountNoValidatorError.EMPTY,
        );
      });

      test('returns invalid length error when full name less than minimum characters', () {
        expect(
          BankAccountNo.dirty(invalidBankAccountMock).error,
          BankAccountNoValidatorError.LENGTH_NOT_VALID,
        );
      });

      test('returns not numeric error when bank account no is not numeric', () {
        expect(
          BankAccountNo.dirty("ASD").error,
          BankAccountNoValidatorError.NOT_NUMERIC,
        );
      });

      test('is valid when bank account no is characters,numeric and minimum length of characters is 8', () {
        expect(
          BankAccountNo.dirty(validBankAccountMock).error,
          isNull,
        );
      });

    });
  });
}
