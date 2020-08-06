import 'package:amar_bank_test/core/dto/registration_data.dart';
import 'package:amar_bank_test/pages/personal_data/models/bank_account_no.dart';
import 'package:amar_bank_test/pages/personal_data/models/date_of_birth.dart';
import 'package:amar_bank_test/pages/personal_data/models/education.dart';
import 'package:amar_bank_test/pages/personal_data/models/fullname.dart';
import 'package:amar_bank_test/pages/personal_data/models/nation_id.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class PersonalDataState extends Equatable {
  const PersonalDataState({
    this.status = FormzStatus.pure,
    this.nationID = const NationID.pure(),
    this.education = const Education.pure(),
    this.fullName = const FullName.pure(),
    this.bankAccountNo = const BankAccountNo.pure(),
    this.dateOfBirth = const DateOfBirth.pure(),
    this.registrationData,
  });

  final FormzStatus status;
  final NationID nationID;
  final Education education;
  final FullName fullName;
  final BankAccountNo bankAccountNo;
  final DateOfBirth dateOfBirth;
  final RegistrationData registrationData;

  PersonalDataState copyWith(
      {FormzStatus status,
      NationID nationID,
      Education education,
      FullName fullName,
      BankAccountNo bankAccountNo,
      DateOfBirth dateOfBirth,
      RegistrationData registrationData}) {
    return new PersonalDataState(
      status: status ?? this.status,
      nationID: nationID ?? this.nationID,
      education: education ?? this.education,
      fullName: fullName ?? this.fullName,
      bankAccountNo: bankAccountNo ?? this.bankAccountNo,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      registrationData: registrationData ?? this.registrationData,
    );
  }

  @override
  List<Object> get props => [
        status,
        nationID,
        education,
        fullName,
        bankAccountNo,
        dateOfBirth,
        registrationData
      ];

  @override
  bool get stringify => true;
}
