import 'package:test/test.dart';
import 'package:hkid_validator/hkid_validator.dart';

void main() {
  int num = 1;
  while (num < 31) {
    String hkid = HKIDValidator().genRanValidHKID();
    test('[TASK-$num]:[VdalidateRandomHKID-$hkid]', () {
      expect(
          HKIDValidator().isHKIDValid(
              hkid.substring(0, hkid.length - 1), hkid.split('').last),
          true);
    });
    num++;
  }
}
