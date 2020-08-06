import 'package:amar_bank_test/pages/address_data/view/address_data_page.dart';
import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView();
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => PersonalDataPage.route(),
    );
  }
}
