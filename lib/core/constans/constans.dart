import 'package:flutter/material.dart';

// SizedBox Spacer
abstract class Constants {
  //Horizontal Spacer
  static SizedBox veryTinyHorizontalSpacer = const SizedBox(width: 2);
  static SizedBox tinyHorizontalSpacer = const SizedBox(width: 4);
  static SizedBox smallHorizontalSpacer = const SizedBox(width: 8);
  static SizedBox mediumHorizontalSpacer = const SizedBox(width: 16);
  static SizedBox largeHorizontalSpacer = const SizedBox(width: 24);
  static SizedBox xLargeHorizontalSpacer = const SizedBox(width: 32);
  static SizedBox xxLargeHorizontalSpacer = const SizedBox(width: 40);

  //Vertical Spacer
  static SizedBox veryTinyVerticalSpacer = const SizedBox(height: 2);
  static SizedBox tinyVerticalSpacer = const SizedBox(height: 4);
  static SizedBox smallVerticalSpacer = const SizedBox(height: 8);
  static SizedBox mediumVerticalSpacer = const SizedBox(height: 16);
  static SizedBox largeVerticalSpacer = const SizedBox(height: 24);
  static SizedBox xLargeVerticalSpacer = const SizedBox(height: 32);
  static SizedBox xxLargeVerticalSpacer = const SizedBox(height: 40);

  static const String editPopUp = 'ویرایش';
  static const String removePopUp = 'حذف';
}

// SharedPreferencesKeys

const String factorHomeListSharedPreferencesKey = 'factorHomeListKey';
const String unofficialFactorSharedPreferencesKey = 'unofficialFactorListKey';
const String myProfileSharedPreferencesKey = 'myProfileSharedPreferencesKey1';

const String buyerSharedPreferencesKey = 'buyerSharedPreferencesKey2';

// Png
const String emptyList = 'assets/images/png/empty_list.png';
const String signatureIcon = 'assets/images/png/signature.png';
const String sealIcon = 'assets/images/png/seal_icon.png';
const String buyerEmptyListIcon = 'assets/images/png/buyer_empty_list_icon.png';

const String addFactorUnofficialIcon =
    'assets/images/png/add-factor-unofficial.png';
const String addFactorOfficialIcon =
    'assets/images/png/add-factor-official.png';
const String purchaseRecordsIcon = 'assets/images/png/purchase_records.png';
const String cartIcon = 'assets/images/png/cart.png';
const String settingIcon = 'assets/images/png/setting.png';
const String messageIcon = 'assets/images/png/message.png';
const String supportIcon = 'assets/images/png/support.png';
const String goldCupIcon = 'assets/images/png/gold_cup.png';
const String lightIcon = 'assets/images/png/light-icon.png';
const String darkIcon = 'assets/images/png/dark-mode.png';
const String moreIcon = 'assets/images/png/more.png';
const String homeIcon = 'assets/images/png/home.png';
const String barcodeScannerIcon = 'assets/images/png/barcode-scanner.png';
const String addTaskIcon = 'assets/images/png/add_task.png';
const String addTaskIconFilledIcon = 'assets/images/png/addTaskIconFilled.png';
const String logoDesignIcon = 'assets/images/png/logo-design.png';

//gif
const String splashIcon = 'assets/images/gif/receipt.gif';
// const String emptyList = 'assets/images/gif/empty-list.gif';
const String pencilLoading = 'assets/images/gif/pencil-loading.gif';

Color dividerColor = const Color(0xffe6e6e6);
Color settingIconColor = const Color(0xff74736f);
Color settingTextColor = const Color(0xff30302e);
Color backGroundScaffoldColor = const Color(0xfff2f6fc);
