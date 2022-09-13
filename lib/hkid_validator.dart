library hkid_validator;

import 'dart:math';
import 'const/alphabat_to_num.dart';

extension HKIDWithParentheses on String {
  // Add Parentheses at the last character
  String withPARES() {
    return '${substring(0, length - 1)}(${substring(length - 1)})';
  }
}

int recussiveMultiplySum({required List<int> list, required int value}) {
  int multiplyValue = list.first * value;
  return list.length == 1
      ? multiplyValue
      : multiplyValue +
          recussiveMultiplySum(list: list.sublist(1), value: value - 1);
}

List<int> _genDigitsBody({required int times}) {
  Random random = Random();
  List<int> body = [];
  for (int i = 0; i < times; i++) {
    body.add(random.nextInt(10));
  }
  return body;
}

class HKIDValidator {
  static final _validator = HKIDValidator._internal();
  factory HKIDValidator() => _validator;
  HKIDValidator._internal();

  int _alphabetIndex(String char) =>
      alphabetToNum.containsKey(char) ? alphabetToNum[char]! : 0;

  bool _isCheckSumValid(int sum, String lastChar) {
    bool isValid = false;
    int rest = sum % 11;
    int value = lastChar.contains(RegExp(r'[A-Z]'))
        ? _alphabetIndex(lastChar)
        : int.tryParse(lastChar)!;
    if (rest == 0) {
      isValid = value == 0 ? true : false;
    } else if (rest == 1) {
      isValid = value == 10 ? true : false;
    } else if (rest >= 2 && rest <= 10) {
      isValid = (11 - rest) == value ? true : false;
    }
    return isValid;
  }

  String _gendigitTail(int sum) {
    int rest = sum % 11;
    if (rest == 0) {
      return '0';
    } else if (rest == 1) {
      return 'A';
    } else {
      return (11 - rest).toString();
    }
  }

  String _generateID({bool isEightNum = false}) {
    String hkid = '';
    if (isEightNum) {
      int digitHead = alphabetToNum[alphabetToNum.keys
          .toList()[Random().nextInt(alphabetToNum.keys.length)]]!;
      List<int> digitBody = _genDigitsBody(times: 6);
      var sum = 36 * 9 +
          digitHead * 8 +
          recussiveMultiplySum(list: digitBody, value: 7);
      hkid = numToAlphabet[digitHead]! + digitBody.join() + _gendigitTail(sum);
    } else if (isEightNum == false) {
      int firstDigitHead = alphabetToNum[alphabetToNum.keys
          .toList()[Random().nextInt(alphabetToNum.keys.length)]]!;
      int secDigitHead = alphabetToNum[alphabetToNum.keys
          .toList()[Random().nextInt(alphabetToNum.keys.length)]]!;
      List<int> digitBody = _genDigitsBody(times: 6);
      var sum = firstDigitHead * 9 +
          secDigitHead * 8 +
          recussiveMultiplySum(list: digitBody, value: 7);
      hkid = numToAlphabet[firstDigitHead]! +
          numToAlphabet[secDigitHead]! +
          digitBody.join() +
          _gendigitTail(sum);
    } else {}
    return hkid;
  }

  String genValidHKID({required bool isEight}) =>
      _generateID(isEightNum: isEight);

  String genRanValidHKID() {
    Random digitRandom = Random();
    int idDigits = digitRandom.nextInt(2) + 8;
    return _generateID(isEightNum: idDigits == 8);
  }

  bool isHKIDValid(String id, String specialChar) {
    specialChar = specialChar.toUpperCase();
    String hkid = id.toUpperCase() + specialChar;
    final hkIdRegExp = RegExp(r'^[A-Z]{1,2}[0-9]{6}[0-9A-F]{1}');
    if (hkIdRegExp.hasMatch(hkid)) {
      if (hkid.length == 8) {
        if (_alphabetIndex(hkid[0]) != 0 && _alphabetIndex(hkid[1]) == 0) {
          var sum = 36 * 9 +
              _alphabetIndex(hkid[0]) * 8 +
              recussiveMultiplySum(
                  list: id
                      .substring(1, id.length)
                      .split('')
                      .map((alphabet) => int.tryParse(alphabet)!)
                      .toList(),
                  value: 7);
          return _isCheckSumValid(sum, specialChar);
        } else {
          return false;
        }
      } else if (hkid.length == 9) {
        if (_alphabetIndex(hkid[0]) != 0 && _alphabetIndex(hkid[1]) != 0) {
          int sum = _alphabetIndex(hkid[0]) * 9 +
              _alphabetIndex(hkid[1]) * 8 +
              recussiveMultiplySum(
                  list: id
                      .substring(2, id.length)
                      .split('')
                      .map((alphabet) => int.tryParse(alphabet)!)
                      .toList(),
                  value: 7);
          return _isCheckSumValid(sum, specialChar);
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
