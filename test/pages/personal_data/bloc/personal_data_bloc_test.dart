import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_bloc.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PersonalDataBloc bloc;

  setUp(() {
    bloc = PersonalDataBloc();
  });

  group("Personal Data Bloc", () {
    test('initial state is PersonalDataBloc', () {
      expect(bloc.state, PersonalDataState());
    });
  });
}
