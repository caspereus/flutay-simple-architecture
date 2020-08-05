import 'package:amar_bank_test/core/repositories/place_repository.dart';
import 'package:amar_bank_test/pages/personal_data/personal_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.placeRepository,
  })  : assert(placeRepository != null),
        super(key: key);

  final PlaceRepository placeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: placeRepository,
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => PersonalDataPage.route(),
    );
  }
}
