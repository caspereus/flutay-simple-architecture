import 'package:amar_bank_test/core/dto/personal_data.dart';
import 'package:amar_bank_test/core/dto/registration_data.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_event.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_state.dart';
import 'package:amar_bank_test/pages/personal_data/models/bank_account_no.dart';
import 'package:amar_bank_test/pages/personal_data/models/date_of_birth.dart';
import 'package:amar_bank_test/pages/personal_data/models/education.dart';
import 'package:amar_bank_test/pages/personal_data/models/fullname.dart';
import 'package:amar_bank_test/pages/personal_data/models/nation_id.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

class PersonalDataBloc extends Bloc<PersonalDataEvent, PersonalDataState> {
  PersonalDataBloc() : super(PersonalDataState());

  @override
  void onTransition(
      Transition<PersonalDataEvent, PersonalDataState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<PersonalDataState> mapEventToState(PersonalDataEvent event) async* {
    if (event is PersonalDataNationIDChanged) {
      yield _mapNationIDChangedToState(event, state);
    } else if (event is PersonalDataFullNameChanged) {
      yield _mapFullNameChangedToState(event, state);
    } else if (event is PersonalDataBankAccountNoChanged) {
      yield _mapBankAccountNoChangedToState(event, state);
    } else if (event is PersonalDataEducationChanged) {
      yield _mapEducationChangedToState(event, state);
    } else if (event is PersonalDataDateOfBirthChanged) {
      yield _mapDateOfBirthChangedToState(event, state);
    } else if (event is PersonalDataSubmitted) {
      yield* _mapPersonalDataSubmittedToState(event, state);
    }
  }

  PersonalDataState _mapNationIDChangedToState(
    PersonalDataNationIDChanged event,
    PersonalDataState state,
  ) {
    final nationID = NationID.dirty(event.nationID);
    return state.copyWith(
      nationID: nationID,
      status: Formz.validate([
        nationID,
        state.fullName,
        state.education,
        state.bankAccountNo,
        state.dateOfBirth
      ]),
    );
  }

  PersonalDataState _mapFullNameChangedToState(
    PersonalDataFullNameChanged event,
    PersonalDataState state,
  ) {
    final fullName = FullName.dirty(event.fullName);
    return state.copyWith(
      fullName: fullName,
      status: Formz.validate([
        state.nationID,
        fullName,
        state.education,
        state.bankAccountNo,
        state.dateOfBirth
      ]),
    );
  }

  PersonalDataState _mapBankAccountNoChangedToState(
    PersonalDataBankAccountNoChanged event,
    PersonalDataState state,
  ) {
    final bankAccountNo = BankAccountNo.dirty(event.bankAccountNo);
    return state.copyWith(
      bankAccountNo: bankAccountNo,
      status: Formz.validate([
        state.nationID,
        state.fullName,
        state.education,
        bankAccountNo,
        state.dateOfBirth
      ]),
    );
  }

  PersonalDataState _mapEducationChangedToState(
    PersonalDataEducationChanged event,
    PersonalDataState state,
  ) {
    final education = Education.dirty(event.education);
    return state.copyWith(
      education: education,
      status: Formz.validate([
        state.nationID,
        state.fullName,
        education,
        state.bankAccountNo,
        state.dateOfBirth
      ]),
    );
  }

  PersonalDataState _mapDateOfBirthChangedToState(
    PersonalDataDateOfBirthChanged event,
    PersonalDataState state,
  ) {
    final dateOfBirth = DateOfBirth.dirty(event.dateOfBirth);
    return state.copyWith(
      dateOfBirth: dateOfBirth,
      status: Formz.validate([
        state.nationID,
        state.fullName,
        state.education,
        state.bankAccountNo,
        dateOfBirth
      ]),
    );
  }

  Stream<PersonalDataState> _mapPersonalDataSubmittedToState(
    PersonalDataSubmitted event,
    PersonalDataState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionSuccess);
      try {

        PersonalData personalDataDTO = PersonalData(
          nationId: state.nationID,
          education: state.education,
          bankAccountNo: state.bankAccountNo,
          fullName: state.fullName,
          dateOfBirth: state.dateOfBirth,
        );

        RegistrationData registrationData = RegistrationData(
          personalData: personalDataDTO,
        );

        yield state.copyWith(
          status: FormzStatus.submissionSuccess,
          registrationData: registrationData,
        );
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
