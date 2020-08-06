import 'package:amar_bank_test/pages/personal_data/models/bank_account_no.dart';
import 'package:amar_bank_test/pages/personal_data/models/date_of_birth.dart';
import 'package:amar_bank_test/pages/personal_data/models/education.dart';
import 'package:amar_bank_test/pages/personal_data/models/fullname.dart';
import 'package:amar_bank_test/pages/personal_data/models/nation_id.dart';
import 'package:flutter/cupertino.dart';

class PersonalData {
  final NationID nationId;
  final Education education;
  final BankAccountNo bankAccountNo;
  final FullName fullName;
  final DateOfBirth dateOfBirth;

  PersonalData({
    @required this.nationId,
    @required this.education,
    @required this.bankAccountNo,
    @required this.fullName,
    @required this.dateOfBirth,
  })  : assert(nationId != null),
        assert(education != null),
        assert(bankAccountNo != null),
        assert(dateOfBirth != null);
}
