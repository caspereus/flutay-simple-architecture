import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Personal Data Page", () {
    test("is routeable", () {
      expect(PersonalDataPage.route(), isA<MaterialPageRoute>());
    });

    testWidgets("renders Personal Page Form", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PersonalDataPage(),
        ),
      ));
      expect(find.byType(PersonalDataForm), findsOneWidget);
    });
  });
}
