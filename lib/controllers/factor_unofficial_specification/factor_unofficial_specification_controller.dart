import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/buyer_view_model/buyer_view_model.dart';
import 'package:factor_flutter_mobile/models/custom_pdf_size/custom_pdf_size_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_header/factor_header_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FactorUnofficialSpecificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    initSharedPreferences();
    scrollController.addListener(() {
      offsetScroll.value = scrollController.offset;
      if (offsetScroll.value > 10) {
        isExpandedBottomSheet(false);
      }
    });
    statusFunction();
  }

  Rxn<CustomPdfSizeViewModel> customPdfSizeViewModel =
      Rxn<CustomPdfSizeViewModel>();

  final RxList<FactorHomeViewModel> factorHomeList;

  RxList<SpecificationCostViewModel> emptyList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> excessCostList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> cartList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> cashList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> onlinePayList =
      <SpecificationCostViewModel>[].obs;

  RxList<SpecificationCostViewModel> checkPayList =
      <SpecificationCostViewModel>[].obs;

  // TextEditingController excessCostTitleTextEditingController =
  //     TextEditingController();
  // TextEditingController excessCostPriceTextEditingController =
  //     TextEditingController();

  TextEditingController cartTitleTextEditingController =
      TextEditingController();
  TextEditingController cartPriceTextEditingController =
      TextEditingController();

  TextEditingController cashTitleTextEditingController =
      TextEditingController();
  TextEditingController cashPriceTextEditingController =
      TextEditingController();

  TextEditingController onlinePayTitleTextEditingController =
      TextEditingController();
  TextEditingController onlinePayPriceTextEditingController =
      TextEditingController();

  TextEditingController checkPayTitleTextEditingController =
      TextEditingController();
  TextEditingController checkPayPriceTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController(
      text:
          'در این قسمت توضیحات قرار می گیرد میتوانید از قسمت توضیحات فاکتور آن را تغییر یا حذف کنید');

  RxDouble offsetScroll = 0.0.obs;
  final ScrollController scrollController = ScrollController();
  GlobalKey<FormState> excessCostFormKey =
      GlobalKey<FormState>(debugLabel: '1');
  GlobalKey<FormState> cartFormKey = GlobalKey<FormState>(debugLabel: '2');
  GlobalKey<FormState> cashFormKey = GlobalKey<FormState>(debugLabel: '3');
  GlobalKey<FormState> onlinePayFormKey = GlobalKey<FormState>(debugLabel: '4');
  GlobalKey<FormState> checkPayFormKey = GlobalKey<FormState>(debugLabel: '5');

  final RxList<FactorUnofficialItemViewModel> factorUnofficialItemList;
  RxBool isExpandedBottomSheet = false.obs;
  RxInt statusBracketKeyText = 0.obs;
  RxBool isLoadingCreatePdf = false.obs;

  RxDouble totalPrice;
  final String taxation;
  final String discount;
  final String currencyTitle;
  Rxn<BuyerViewModel> buyerItem = Rxn<BuyerViewModel>();
  Rxn<MyProfileViewModel> myProfileItem = Rxn<MyProfileViewModel>();
  Rxn<FactorHeaderViewModel> factorHeaderViewModel =
      Rxn<FactorHeaderViewModel>();
  RxBool isSelectedBuyerName = false.obs;
  RxBool isMyProfileItemNull = false.obs;
  Uuid uUid = const Uuid();
  int factorNumber = 1;

  FactorUnofficialSpecificationController({
    required this.factorHomeList,
    required this.factorUnofficialItemList,
    required this.totalPrice,
    required this.taxation,
    required this.discount,
    required this.currencyTitle,
  });

  RxDouble totalPriceAllItems() {
    RxDouble _totalPrice = 0.0.obs;
    _totalPrice.value = totalExcessCostPrice() -
        totalCashPrice() -
        totalCartPrice() -
        totalOnlinePayPrice() -
        totalCheckPayPrice();

    return _totalPrice;
  }

  double totalExcessCostPrice() {
    double _price = 0;
    _price = totalPrice.value;
    for (var element in excessCostList) {
      _price += double.parse(element.price.replaceAll(RegExp(','), ''));
    }
    return _price;
  }

  double totalCashPrice() {
    double _price = 0;
    for (var element in cashList) {
      _price += double.parse(element.price.replaceAll(RegExp(','), ''));
    }
    return _price;
  }

  double totalCartPrice() {
    double _price = 0;
    for (var element in cartList) {
      _price += double.parse(element.price.replaceAll(RegExp(','), ''));
    }
    return _price;
  }

  double totalOnlinePayPrice() {
    double _price = 0;
    for (var element in onlinePayList) {
      _price += double.parse(element.price.replaceAll(RegExp(','), ''));
    }
    return _price;
  }

  double totalCheckPayPrice() {
    double _price = 0;
    for (var element in checkPayList) {
      _price += double.parse(element.price.replaceAll(RegExp(','), ''));
    }
    return _price;
  }

  void statusFunction() {
    if (totalPriceAllItems().value < 0.0) {
      statusBracketKeyText(1);
    } else if (totalPriceAllItems().value == 0.0) {
      statusBracketKeyText(3);
    } else {
      statusBracketKeyText(0);
    }
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadMyProfileData();
    loadFactorHeaderData();
    loadPdfPaperData();
    loadSubscription();
  }

  void loadPdfPaperData() {
    String pdfPaperData =
        sharedPreferences.getString(customPdfSizeSharedPreferencesKey) ?? '';

    if (pdfPaperData.isNotEmpty) {
      customPdfSizeViewModel.value =
          CustomPdfSizeViewModel.fromJson(jsonDecode(pdfPaperData));
    }
  }

  PdfPageFormat pageFormatFactor() {
    if (customPdfSizeViewModel.value == null) {
      return PdfPageFormat.a4;
    } else if (customPdfSizeViewModel.value?.pdfFormat == 0) {
      return PdfPageFormat.a3;
    } else if (customPdfSizeViewModel.value?.pdfFormat == 1) {
      return PdfPageFormat.a4;
    } else {
      return PdfPageFormat.a5;
    }
  }

  void loadMyProfileData() {
    final myProfileData =
        sharedPreferences.getString(myProfileSharedPreferencesKey) ?? '';

    if (myProfileData.isNotEmpty) {
      myProfileItem.value =
          MyProfileViewModel.fromJson(jsonDecode(myProfileData));
      isMyProfileItemNull(true);
      log(myProfileData);
    } else {
      log('isEmpty');
    }
  }

  void loadFactorHeaderData() {
    String factorHeaderData =
        sharedPreferences.getString(factorHeaderSharedPreferencesKey) ?? '';

    if (factorHeaderData.isNotEmpty) {
      factorHeaderViewModel.value =
          FactorHeaderViewModel.fromJson(jsonDecode(factorHeaderData));
      log(factorHeaderData);
    } else {
      factorNumber = factorHomeList.length + 1;
      log('isEmpty3$factorNumber');
    }
  }

  void buttonOnTapItem({
    required RxList<SpecificationCostViewModel> listItem,
    required TextEditingController titleTextEditingController,
    required TextEditingController priceTextEditingController,
  }) {
    listItem.add(SpecificationCostViewModel(
        id: uUid.v4(),
        price: priceTextEditingController.text,
        title: titleTextEditingController.text));
    Get.back();

    priceTextEditingController.clear();
    titleTextEditingController.clear();
  }

  void buttonCashAdd() {
    if (!cashFormKey.currentState!.validate()) return;

    buttonOnTapItem(
        listItem: cashList,
        titleTextEditingController: cashTitleTextEditingController,
        priceTextEditingController: cashPriceTextEditingController);
  }

  void buttonCartAdd() {
    if (!cartFormKey.currentState!.validate()) return;

    buttonOnTapItem(
        listItem: cartList,
        titleTextEditingController: cartTitleTextEditingController,
        priceTextEditingController: cartPriceTextEditingController);
  }

  void buttonOnlinePayAdd() {
    if (!onlinePayFormKey.currentState!.validate()) return;

    buttonOnTapItem(
        listItem: onlinePayList,
        titleTextEditingController: onlinePayTitleTextEditingController,
        priceTextEditingController: onlinePayPriceTextEditingController);
  }

  void buttonCheckPayAdd() {
    if (!checkPayFormKey.currentState!.validate()) return;

    buttonOnTapItem(
        listItem: checkPayList,
        titleTextEditingController: checkPayTitleTextEditingController,
        priceTextEditingController: checkPayPriceTextEditingController);
  }

  void addToHomeFactor({required Uint8List uint8ListPdf}) {
    factorHomeList.add(FactorHomeViewModel(
      totalPrice: totalPriceAllItems().value,
      id: uUid.v4(),
      uint8ListPdf: base64Encode(uint8ListPdf),
      dateFactor: factorHeaderViewModel.value?.factorDate ??
          Jalali.now().formatCompactDate(),
      numFactor: factorHeaderViewModel.value?.factorNum ??
          '${factorHomeList.length + 1}',
      titleFactor: factorHeaderViewModel.value?.title ?? 'فاکتور فروش',
    ));
    saveFactorData();
  }

  void saveFactorData() {
    List<String> factorDataList =
        factorHomeList.map((element) => json.encode(element.toJson())).toList();
    sharedPreferences.setStringList(
        factorHomeListSharedPreferencesKey, factorDataList);
    print('factorDataListUni$factorDataList');
  }

  RxString subscriptionValue = ''.obs;

  void loadSubscription() {
    String subscriptionData =
        sharedPreferences.getString(subscriptionSharedPreferencesKey) ?? '';
    if (subscriptionData.isNotEmpty) {
      subscriptionValue.value = subscriptionData;
    }
    log('loadSubscription${subscriptionData}');
  }

  RxBool subscriptionCondition() {
    if (subscriptionValue.value == 'bronze_buy') {
      if (factorHomeList.length >= 29) {
        return false.obs;
      } else {
        return true.obs;
      }
    } else if (subscriptionValue.value == 'silver') {
      if (factorHomeList.length >= 59) {
        return false.obs;
      } else {
        return true.obs;
      }
    } else if (subscriptionValue.value == 'gold') {
      if (factorHomeList.length >= 999999999999999999) {
        return false.obs;
      } else {
        return true.obs;
      }
    } else {
      return false.obs;
    }
  }

  bool isShowFactorParBottomInPdf() {
    if (subscriptionValue.value == 'gold' ||
        subscriptionValue.value == 'silver') {
      return false;
    } else {
      return true;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
