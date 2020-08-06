import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_state.dart';
import 'package:amar_bank_test/pages/personal_data/models/bank_account_no.dart';
import 'package:amar_bank_test/pages/personal_data/models/date_of_birth.dart';
import 'package:amar_bank_test/pages/personal_data/models/education.dart';
import 'package:amar_bank_test/pages/personal_data/models/fullname.dart';
import 'package:amar_bank_test/pages/personal_data/models/nation_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';

void main() {
  const nationId = NationID.dirty('');
  const fullName = FullName.dirty('');
  const education = Education.dirty();
  const bankAccountNo = BankAccountNo.dirty();
  const dateOfBirth = DateOfBirth.dirty();

  group("Personal Data State", () {
    test('supports value comparisons', () {
      expect(PersonalDataState(), PersonalDataState());
    });

    test('returns same object when no properties are passed', () {
      expect(PersonalDataState().copyWith(), PersonalDataState());
    });

    test('returns object with updated status when status is passed', () {
      expect(
        PersonalDataState().copyWith(status: FormzStatus.pure),
        PersonalDataState(status: FormzStatus.pure),
      );
    });

    test('returns object with updated nation id when status is passed', () {
      expect(
        PersonalDataState().copyWith(nationID: nationId),
        PersonalDataState(nationID: nationId),
      );
    });

    test('returns object with updated full name when status is passed', () {
      expect(
        PersonalDataState().copyWith(fullName: fullName),
        PersonalDataState(fullName: fullName),
      );
    });

    test('returns object with updated education when status is passed', () {
      expect(
        PersonalDataState().copyWith(education: education),
        PersonalDataState(education: education),
      );
    });

    test('returns object with updated bank account no when status is passed',
        () {
      expect(
        PersonalDataState().copyWith(bankAccountNo: bankAccountNo),
        PersonalDataState(bankAccountNo: bankAccountNo),
      );
    });

    test('returns object with updated date of birth when status is passed', () {
      expect(
        PersonalDataState().copyWith(dateOfBirth: dateOfBirth),
        PersonalDataState(dateOfBirth: dateOfBirth),
      );
    });
  });
}
