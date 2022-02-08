import 'package:factor_flutter_mobile/core/utils/factor_validation/factor_validation.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

String? Function(String?) mobileNumberValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isValidIranianMobileNumber()
            ? null
            : 'شماره همراه اشتباه است';

String? Function(String?) shabaNumberValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isShabaNumerCurrect(value)
            ? null
            : 'شماره شبا اشتباه است';

String? Function(String?) nationalCodeValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isValidIranianNationalCode()
            ? null
            : ' کد ملی اشتباه است';

String? Function(String?) nationalCodeValidatorWithOutRequiredEmpty(
        String fieldName) =>
    (String? value) =>
        value!.isValidIranianNationalCode() ? null : ' فکر کنم کد ملیت اشتباهه';
String? Function(String?) mobileNumberValidatorWithOutRequiredEmpty(
        String fieldName) =>
    (String? value) => value!.isValidIranianMobileNumber()
        ? null
        : 'فکر کنم شماره همراهت اشتباهه';

String? Function(String?) phoneNumberValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isPhoneNumber(value)
            ? null
            : 'شماره تلفن اشتباه است';

String? Function(String?) cardShetabNumberValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isCardNumberIsCorrect(value)
            ? null
            : 'شماره کارت اشتباه است';

String? Function(String?) emptyValidator(String fieldName) =>
    (String? value) => value?.trim().isNotEmpty != true
        ? '$fieldName رو یادت رفت وارد کنی '
        : null;

String? Function(String?) percentValidator(String fieldName) =>
    (String? value) {
      if (value?.trim().isNotEmpty != true) {
        return '$fieldName خالی است ';
      } else {
        null;
      }
      return double.parse(value!.trim()) > 100
          ? ' درصد $fieldName نامعتبر '
          : null;
    };
