
import 'package:factor_flutter_mobile/core/utils/factor_validation/factor_validation.dart';

String? Function(String?) mobileNumberValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isMobileNumber(value)
        ? null
        : 'شماره همراه اشتباه است';

String? Function(String?) shabaNumberValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isShabaNumerCurrect(value)
        ? null
        : 'شماره شبا اشتباه است';

String? Function(String?) nationalCodeValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isNationalCode(value)
        ? null
        : ' کد ملی اشتباه است';

String? Function(String?) phoneNumberValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isPhoneNumber(value)
        ? null
        : 'شماره تلفن اشتباه است';


String? Function(String?) cardShetabNumberValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true
        ? '$fieldName اجباری است '
        : value!.isCardNumberIsCorrect(value)
        ? null
        : 'شماره کارت اشتباه است';

String? Function(String?) emptyValidator(String fieldName) =>
        (String? value) =>
    value
        ?.trim()
        .isNotEmpty != true ? '$fieldName اجباری است ' : null;

String? Function(String?) percentValidator(String fieldName) =>
    (String? value) {
      if (value?.trim().isNotEmpty != true) {
          return
        '$fieldName خالی است ';
      } else {

        null;
      }
      return int.parse(value!.trim()) > 100
          ? ' درصد $fieldName نامعتبر '
          : null;
    };