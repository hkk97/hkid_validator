import 'package:flutter_test/flutter_test.dart';
import 'package:hkid_validator/hkid_validator.dart';

const List<String> listOfValidId = [
  'U4439020',
  'J6460523',
  'G856297A',
  'N1392113',
  'G4277022',
  'U8307757',
  'A4837595',
  'S5683221',
  'I0267605',
  'V8240477',
  'AG9902661',
  'I4127069',
  'N2237820',
  'V0265918',
  'K8912092',
  'Y1231861',
  'R0706727',
  'B0422857',
  'GQ7576889',
  'M8488881',
  'L0750193',
  'B5715755',
  'C8050986',
  'Q1511447',
  'O2271428',
  'R3852554',
  'S753357A',
  'Y7103350',
  'G4081128',
  'V4054911',
  'R7020251',
];
void main() {
  for (int i = 0; i < listOfValidId.length; i++) {
    String hkid = listOfValidId[i];
    test('TASK-${i + 1} HKID-${listOfValidId[i].withPARES()}', () {
      expect(
          HKIDValidator().isHKIDValid(
              hkid.substring(0, hkid.length - 1), hkid.split('').last),
          true);
    });
  }
}
