// ignore_for_file: prefer_const_constructors
import 'package:amar_bank_test/pages/address_data/models/domicile_address.dart';
import 'package:amar_bank_test/pages/personal_data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const domicileAddressMock = "1122334455667788";
  const addressMock =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque accumsan lacus ut hendrerit dictum. Fusce leo augue, euismod lacinia ex ac, venenatis aliquet metus. Donec ornare erat dui, ut pulvinar orci porttitor eu. Etiam eleifend sodales orci aliquam suscipit. Donec vitae quam pharetra, porttitor augue in, commodo ex. Suspendisse metus purus, accumsan id est eget, ultricies tempus mauris. Suspendisse metus lorem, malesuada ut velit vitae, pretium tempor tortor. Pellentesque tincidunt sollicitudin justo quis consectetur.Suspendisse in aliquet quam. Aenean ornare tristique ex, vitae vulputate mi bibendum eget. Sed nec mi vel dui mollis sagittis. Duis non rutrum diam, in suscipit.";
  group('Domicile Address', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final domicileAddress = DomicileAddress.pure();
        expect(domicileAddress.value, '');
        expect(domicileAddress.pure, true);
      });

      test('dirty creates correct instance', () {
        final domicileAddress = DomicileAddress.dirty(domicileAddressMock);
        expect(domicileAddress.value, domicileAddressMock);
        expect(domicileAddress.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when domicile address is empty', () {
        expect(
          DomicileAddress.dirty('').error,
          DomicileAddressValidatorError.EMPTY,
        );
      });

      test('returns invalid length error when exceed the maximum characters',
          () {
        expect(
          DomicileAddress.dirty(addressMock).error,
          DomicileAddressValidatorError.LENGTH_NOT_VALID,
        );
      });

      test(
          'is valid when domicile address is not empty & char length less than 100',
          () {
        expect(
          DomicileAddress.dirty(domicileAddressMock).error,
          isNull,
        );
      });
    });
  });
}
