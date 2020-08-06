import 'package:amar_bank_test/core/network/api.dart';
import 'package:amar_bank_test/core/repositories/impl/place_repository_impl.dart';
import 'package:amar_bank_test/core/repositories/place_repository.dart';
import 'package:amar_bank_test/core/services/auth_service.dart';
import 'package:amar_bank_test/core/services/place_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  _registerNetwork();
  _registerRepositories();
  _registerServices();
}

void _registerNetwork() {
  locator.registerSingleton<Api>(Api());
}

void _registerRepositories() {
  locator.registerLazySingleton<PlaceRepository>(
    () => PlaceRepositoryImpl(
      api: locator<Api>(),
    ),
  );
}

void _registerServices() {
  locator.registerLazySingleton<AuthService>(
    () => AuthService(),
  );

  locator.registerLazySingleton<PlaceService>(
    () => PlaceService(
      placeRepository: locator<PlaceRepository>(),
    ),
  );
}
