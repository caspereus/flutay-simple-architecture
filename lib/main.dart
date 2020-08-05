import 'package:amar_bank_test/app.dart';
import 'package:amar_bank_test/core/repositories/place_repository.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(App(
    placeRepository: PlaceRepository(),
  ));
}
