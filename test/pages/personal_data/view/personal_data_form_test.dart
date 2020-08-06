import 'package:amar_bank_test/core/di/locator.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_event.dart';
import 'package:amar_bank_test/pages/personal_data/bloc/personal_data_state.dart';
import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mockito/mockito.dart';

class MockPersonalDataBloc extends Mock implements PersonalDataBloc {}

void main() {
  group("Personal data form", () {
    MockPersonalDataBloc bloc;

    setUpAll(() {
      bloc = MockPersonalDataBloc();
      setupLocator();
    });

    testWidgets(
        'adds PersonalDataNationIDChanged to PersonalDataBloc when nation id is updated',
        (tester) async {
      const nationId = "1122334455667788";
      when(bloc.state).thenReturn(const PersonalDataState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('personalDataForm_nationIDInput_textField')),
        nationId,
      );
      verify(
        bloc.add(PersonalDataNationIDChanged(nationId)),
      ).called(1);
    });

    testWidgets(
        'adds PersonalDataFullNameChanged to PersonalDataBloc when full name is updated',
        (tester) async {
      const fullName = "Ald";
      when(bloc.state).thenReturn(const PersonalDataState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('personalDataForm_fullNameInput_textField')),
        fullName,
      );
      verify(
        bloc.add(PersonalDataFullNameChanged(fullName)),
      ).called(1);
    });

    testWidgets(
        'adds PersonalDataBankAccountNoChanged to PersonalDataBloc when bank account no is updated',
        (tester) async {
      const bankAccountNo = "12345678";
      when(bloc.state).thenReturn(const PersonalDataState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('personalDataForm_BankAccountNo_textField')),
        bankAccountNo,
      );
      verify(
        bloc.add(PersonalDataBankAccountNoChanged(bankAccountNo)),
      ).called(1);
    });

    testWidgets('submit button disabled by default', (tester) async {
      when(bloc.state).thenReturn(const PersonalDataState());
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );

      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.enabled, isFalse);
    });

    testWidgets(
        'loading indicator is shown when status is submission in progress',
        (tester) async {
      when(bloc.state).thenReturn(
        const PersonalDataState(status: FormzStatus.submissionInProgress),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );
      expect(find.byType(RaisedButton), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('submit button is enabled when status is validated',
        (tester) async {
      when(bloc.state).thenReturn(
        const PersonalDataState(status: FormzStatus.valid),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );
      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.enabled, isTrue);
    });

    testWidgets(
        'PersonalDataSubmitted is added to PersonalPageBloc when submit button is tapped',
        (tester) async {
      when(bloc.state).thenReturn(
        const PersonalDataState(status: FormzStatus.valid),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider<PersonalDataBloc>(
              create: (context) => bloc,
              child: PersonalDataForm(),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(RaisedButton));
      verify(bloc.add(PersonalDataSubmitted())).called(1);
    });

//    testWidgets('shows SnackBar when status is submission success',
//        (tester) async {
//      whenListen(
//        bloc,
//        Stream.fromIterable([
//          const PersonalDataState(status: FormzStatus.submissionInProgress),
//          const PersonalDataState(status: FormzStatus.submissionSuccess),
//        ]),
//      );
//      when(bloc.state).thenReturn(
//        const PersonalDataState(status: FormzStatus.submissionSuccess),
//      );
//      await tester.pumpWidget(
//        MaterialApp(
//          home: Scaffold(
//            body: BlocProvider<PersonalDataBloc>(
//              create: (context) => bloc,
//              child: PersonalDataForm(),
//            ),
//          ),
//        ),
//      );
//      await tester.pump();
//      expect(find.byType(SnackBar), findsOneWidget);
//    });
  });
}
