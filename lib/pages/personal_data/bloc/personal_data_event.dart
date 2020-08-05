import 'package:equatable/equatable.dart';


abstract class PersonalDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PersonalDataNationIDChanged extends PersonalDataEvent {
  PersonalDataNationIDChanged(this.nationID);

  final String nationID;

  @override
  List<Object> get props => [nationID];
}

class PersonalDataEducationChanged extends PersonalDataEvent {
  PersonalDataEducationChanged(this.education);

  final String education;

  @override
  List<Object> get props => [education];
}

class PersonalDataFullNameChanged extends PersonalDataEvent {
  PersonalDataFullNameChanged(this.fullName);

  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class PersonalDataBankAccountNoChanged extends PersonalDataEvent {
  PersonalDataBankAccountNoChanged(this.bankAccountNo);

  final String bankAccountNo;

  @override
  List<Object> get props => [bankAccountNo];
}

class PersonalDataDateOfBirthChanged extends PersonalDataEvent {
  PersonalDataDateOfBirthChanged(this.dateOfBirth);

  final String dateOfBirth;

  @override
  List<Object> get props => [dateOfBirth];
}

class PersonalDataSubmitted extends PersonalDataEvent {}
