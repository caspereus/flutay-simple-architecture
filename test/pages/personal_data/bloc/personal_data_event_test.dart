import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_event.dart';
import 'package:amar_bank_test/pages/personal_data/models/education.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const nationId = "1122334455667788";
  const education = EducationEnum.SMA;
  const fullName = "Ald";
  const bankAccountNo = "12345678";
  const dateOfBirth = "10-10-2001";

  group("Personal Data Event", () {
    group("PersonalDataNationIDChanged", () {
      test('supports value comparisons', () {
        expect(PersonalDataNationIDChanged(nationId),
            PersonalDataNationIDChanged(nationId));
      });
    });

    group("PersonalDataEducationChanged", () {
      test('supports value comparisons', () {
        expect(PersonalDataEducationChanged(education),
            PersonalDataEducationChanged(education));
      });
    });

    group("PersonalDataFullNameChanged", () {
      test('supports value comparisons', () {
        expect(PersonalDataFullNameChanged(fullName),
            PersonalDataFullNameChanged(fullName));
      });
    });

    group("PersonalDataBankAccountNoChanged", () {
      test('supports value comparisons', () {
        expect(PersonalDataBankAccountNoChanged(bankAccountNo),
            PersonalDataBankAccountNoChanged(bankAccountNo));
      });
    });

    group("PersonalDataSubmitted", () {
      test('supports value comparisons', () {
        expect(PersonalDataSubmitted(), PersonalDataSubmitted());
      });
    });
  });
}
