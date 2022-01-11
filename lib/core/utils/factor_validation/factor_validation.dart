List<int> numbers = <int>[
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16
];

extension FactorValidating on String {
  bool isShabaNumerCurrect(String shabaNumber) {
    if (shabaNumber.length < 26) return false;
    final String toLowerShaba = shabaNumber.toUpperCase();
    final String editShabaNumber =
        '${shabaNumber}1827${shabaNumber[2]}${shabaNumber[3]}';
    final String replaceShabaNumber = editShabaNumber.replaceRange(0, 4, '');
    final shabaNum = BigInt.parse(replaceShabaNumber);
    final shabaNumMod = BigInt.from(97);
    final shabaNumResult = shabaNum % shabaNumMod;
    if (toLowerShaba.contains('IR') &&
        shabaNumber.length == 26 &&
        shabaNumResult.toInt() == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isNationalCode(String nationalCode) {
    if (nationalCode.length < 10) return false;
    if (nationalCode.length > 10) return false;

    final int nCode1 = numbers[9] * int.parse(nationalCode[0]);
    final int nCode2 = numbers[8] * int.parse(nationalCode[1]);
    final int nCode3 = numbers[7] * int.parse(nationalCode[2]);
    final int nCode4 = numbers[6] * int.parse(nationalCode[3]);
    final int nCode5 = numbers[5] * int.parse(nationalCode[4]);
    final int nCode6 = numbers[4] * int.parse(nationalCode[5]);
    final int nCode7 = numbers[3] * int.parse(nationalCode[6]);
    final int nCode8 = numbers[2] * int.parse(nationalCode[7]);
    final int nCode9 = numbers[1] * int.parse(nationalCode[8]);

    final int addNationalCode = nCode1 +
        nCode2 +
        nCode3 +
        nCode4 +
        nCode5 +
        nCode6 +
        nCode7 +
        nCode8 +
        nCode9;
    final int modNationalCode = addNationalCode % 11;

    if (modNationalCode < 2 && modNationalCode == int.parse(nationalCode[9])) {
      return true;
    } else {
      final int calculateNationalCode = 11 - modNationalCode;
      if (calculateNationalCode == int.parse(nationalCode[9])) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool isMobileNumber(String mobileNumber) {
    final iranMobileNumberValid = RegExp(
        r'^(0|\+98)?([ ]|-|[()]){0,2}9[1|2|3|4]([ ]|-|[()]){0,2}(?:[0-9]([ ]|-|[()]){0,2}){8}');
    if (iranMobileNumberValid.hasMatch(mobileNumber)) {
      return true;
    } else {
      return false;
    }
  }

//

  bool isPhoneNumber(String phoneNumber) {
    final iranPhoneNumberValid = RegExp(r'^0\d{2,3}\d{8}$');
    if (iranPhoneNumberValid.hasMatch(phoneNumber)) {
      return true;
    } else {
      return false;
    }
  }

  bool isCardNumberIsCorrect(String cardNumber) {
    if (cardNumber.length < 16) {
      return false;
    }

    int cardN1 = int.parse(cardNumber[0]);
    int cardN2 = int.parse(cardNumber[1]);
    int cardN3 = int.parse(cardNumber[2]);
    int cardN4 = int.parse(cardNumber[3]);
    int cardN5 = int.parse(cardNumber[4]);
    int cardN6 = int.parse(cardNumber[5]);
    int cardN7 = int.parse(cardNumber[6]);
    int cardN8 = int.parse(cardNumber[7]);
    int cardN9 = int.parse(cardNumber[8]);
    int cardN10 = int.parse(cardNumber[9]);
    int cardN11 = int.parse(cardNumber[10]);
    int cardN12 = int.parse(cardNumber[11]);
    int cardN13 = int.parse(cardNumber[12]);
    int cardN14 = int.parse(cardNumber[13]);
    int cardN15 = int.parse(cardNumber[14]);
    int cardN16 = int.parse(cardNumber[15]);

    if (numbers[0].isOdd) {
      cardN1 *= 2;
      if (cardN1 > 9) {
        cardN1 -= 9;
      } else {
        cardN1 *= 1;
      }
    }
    if (numbers[1].isOdd) {
      cardN2 *= 2;
      if (cardN2 > 9) {
        cardN2 -= 9;
      } else {
        cardN2 *= 1;
      }
    }
    if (numbers[2].isOdd) {
      cardN3 *= 2;
      if (cardN3 > 9) {
        cardN3 -= 9;
      } else {
        cardN3 *= 1;
      }
    }
    if (numbers[3].isOdd) {
      cardN4 *= 2;
      if (cardN4 > 9) {
        cardN4 -= 9;
      } else {
        cardN4 *= 1;
      }
    }
    if (numbers[4].isOdd) {
      cardN5 *= 2;
      if (cardN5 > 9) {
        cardN5 -= 9;
      } else {
        cardN5 *= 1;
      }
    }
    if (numbers[5].isOdd) {
      cardN6 *= 2;
      if (cardN6 > 9) {
        cardN6 -= 9;
      } else {
        cardN6 *= 1;
      }
    }
    if (numbers[6].isOdd) {
      cardN7 *= 2;
      if (cardN7 > 9) {
        cardN7 -= 9;
      } else {
        cardN7 *= 1;
      }
    }
    if (numbers[7].isOdd) {
      cardN8 *= 2;
      if (cardN8 > 9) {
        cardN8 -= 9;
      } else {
        cardN8 *= 1;
      }
    }
    if (numbers[8].isOdd) {
      cardN9 *= 2;
      if (cardN9 > 9) {
        cardN9 -= 9;
      } else {
        cardN9 *= 1;
      }
    }
    if (numbers[9].isOdd) {
      cardN10 *= 2;
      if (cardN10 > 9) {
        cardN10 -= 9;
      } else {
        cardN10 *= 1;
      }
    }
    if (numbers[10].isOdd) {
      cardN11 *= 2;
      if (cardN11 > 9) {
        cardN11 -= 9;
      } else {
        cardN11 *= 1;
      }
    }
    if (numbers[11].isOdd) {
      cardN12 *= 2;
      if (cardN12 > 9) {
        cardN12 -= 9;
      } else {
        cardN12 *= 1;
      }
    }
    if (numbers[12].isOdd) {
      cardN13 *= 2;
      if (cardN13 > 9) {
        cardN13 -= 9;
      } else {
        cardN13 *= 1;
      }
    }
    if (numbers[13].isOdd) {
      cardN14 *= 2;
      if (cardN14 > 9) {
        cardN14 -= 9;
      } else {
        cardN14 *= 1;
      }
    }
    if (numbers[14].isOdd) {
      cardN15 *= 2;
      if (cardN15 > 9) {
        cardN15 -= 9;
      } else {
        cardN15 *= 1;
      }
    }

    if (numbers[15].isOdd) {
      cardN16 *= 2;
      if (cardN16 > 9) {
        cardN16 -= 9;
      } else {
        cardN16 *= 1;
      }
    }

    final int plusCardCalculate = cardN1 +
        cardN2 +
        cardN3 +
        cardN4 +
        cardN5 +
        cardN6 +
        cardN7 +
        cardN8 +
        cardN9 +
        cardN10 +
        cardN11 +
        cardN12 +
        cardN13 +
        cardN14 +
        cardN15 +
        cardN16;

    if (plusCardCalculate % 10 == 0) {
      return true;
    } else {
      return false;
    }
  }
}
