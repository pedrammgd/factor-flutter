import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/factor_unofficial_specification/factor_unofficial_specification_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/factor_unofficial_specification_dialog.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/factor_unofficial_specification_select_item.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/expandable/factor_expandable.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/show_pdf/show_pdf_view.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class FactorUnofficialSpecificationPage
    extends GetView<FactorUnofficialSpecificationController> {
  const FactorUnofficialSpecificationPage({Key? key}) : super(key: key);

  void initArguments() {
    if (Get.arguments == null) return;
    final arguments = Get.arguments as Map;
    final factorUnofficialItemList = arguments['factorUnofficialItemList'];
    final totalPrice = arguments['totalPrice'];
    final totalWordPrice = arguments['totalWordPrice'];
    final discount = arguments['discount'];
    final taxation = arguments['taxation'];
    Get.lazyPut(() => FactorUnofficialSpecificationController(
        factorUnofficialItemList: factorUnofficialItemList,
        totalPrice: totalPrice,
        totalWordPrice: totalWordPrice,
        discount: discount,
        taxation: taxation));
  }

  @override
  Widget build(BuildContext context) {
    initArguments();
    return Obx(() {
      return Scaffold(
        appBar: FactorAppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              controller.offsetScroll > 30 ? 'فاکتور فروش' : '',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Form(
            // key: controller.formKey,
            child: Column(
              children: [
                _headerFactor(context),
                _ownerItem(),
                Constants.largeVerticalSpacer,
                _buyerItem(),
                Constants.largeVerticalSpacer,
                _excessCostItem(),
                _cashItem(),
                _cartItem(),
                _onlinePayItem(),
                _checkPayItem(),
                Constants.largeVerticalSpacer,
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(),
        bottomNavigationBar: _bottomNavigationBar(),
      );
    });
  }

  Widget _buyerItem() {
    return FactorUnofficialSpecificationSelectItem(
        title: 'طرف حساب ',
        bracesWord: 'مشتری',
        isSelectedName: controller.isSelectedBuyerName.value,
        selectedText: controller
                .buyerItem.value?.personBasicInformationViewModel.fullName ??
            controller
                .buyerItem.value?.personBasicInformationViewModel.companyName ??
            '',
        onTap: () async {
          final result = await Get.toNamed(FactorRoutes.buyer,
              arguments:
                  const BuyerPage().arguments(isEnterFromSpecificFactor: true));
          if (result != null) {
            controller.buyerItem.value = result;
            controller.isSelectedBuyerName.value = true;
          }
        });
  }

  Widget _ownerItem() {
    return FactorUnofficialSpecificationSelectItem(
      isSelectedName: controller.isMyProfileItemNull.value,
      selectedText: controller.myProfileItem.value !=
              null?.personBasicInformationViewModel.isHaghighi
          ? controller.myProfileItem.value?.personBasicInformationViewModel
                  .fullName ??
              ''
          : controller.myProfileItem.value?.personBasicInformationViewModel
                  .companyName ??
              '',
      title: 'صاحب حساب ',
      bracesWord: 'فروشنده',
      onTap: () async {
        final result = await Get.toNamed(
          FactorRoutes.myProfile,
        );

        if (result != null) {
          controller.loadMyProfileData();
        }
      },
    );
  }

  Widget _checkPayItem() {
    return FactorUnofficialSpecificationSelectItem(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
        ],
        textInputType: TextInputType.phone,
        topTextFormFieldLabel: 'شماره سریال',
        bottomTextFormFieldLabel: 'مبلغ',
        titleEdit: 'ویرایش پرداخت چکی',
        topTextEditingController: controller.checkPayTitleTextEditingController,
        bottomTextEditingController:
            controller.checkPayPriceTextEditingController,
        itemList: controller.checkPayList,
        hasBottomItem: true,
        icon: const Icon(Icons.price_change_outlined),
        title: 'پرداخت چکی ',
        hasCustomBeforeTitle: true,
        customBeforeTitle: 'شماره سریال',
        bracesWord: 'چک و سفته ...',
        onTap: () async {
          controller.checkPayPriceTextEditingController.clear();
          controller.checkPayTitleTextEditingController.clear();
          final result = await Get.dialog(
            FactorUnofficialSpecificationDialog(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
                textInputType: TextInputType.phone,
                topTextFormFieldLabel: 'شماره سریال',
                bottomTextFormFieldLabel: 'مبلغ',
                titleButton: 'افزودن',
                title: 'افزودن پرداخت چکی',
                topTextEditingController:
                    controller.checkPayTitleTextEditingController,
                bottomTextEditingController:
                    controller.checkPayPriceTextEditingController,
                buttonOnTap: () => controller.buttonOnTapItem(
                    listItem: controller.checkPayList,
                    titleTextEditingController:
                        controller.checkPayTitleTextEditingController,
                    priceTextEditingController:
                        controller.checkPayPriceTextEditingController)),
          );

          if (result == true) {}
        });
  }

  Widget _onlinePayItem() {
    return FactorUnofficialSpecificationSelectItem(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        textInputType: TextInputType.phone,
        topTextFormFieldLabel: 'شماره پیگیری',
        bottomTextFormFieldLabel: 'قیمت',
        title: 'ویرایش پرداخت آنلاین',
        topTextEditingController:
            controller.onlinePayTitleTextEditingController,
        bottomTextEditingController:
            controller.onlinePayPriceTextEditingController,
        itemList: controller.onlinePayList,
        hasBottomItem: true,
        hasCustomBeforeTitle: true,
        customBeforeTitle: 'شماره پیگیری',
        icon: const Icon(Icons.price_change_outlined),
        titleEdit: 'پرداخت آنلاین ',
        bracesWord: 'اینترنتی و ...',
        onTap: () async {
          controller.onlinePayPriceTextEditingController.clear();
          controller.onlinePayTitleTextEditingController.clear();
          final result = await Get.dialog(
            FactorUnofficialSpecificationDialog(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              textInputType: TextInputType.phone,
              topTextFormFieldLabel: 'شماره پیگیری',
              bottomTextFormFieldLabel: 'قیمت',
              titleButton: 'افزودن',
              title: 'افزودن پرداخت آنلاین',
              topTextEditingController:
                  controller.onlinePayTitleTextEditingController,
              bottomTextEditingController:
                  controller.onlinePayPriceTextEditingController,
              buttonOnTap: () => controller.buttonOnTapItem(
                  listItem: controller.onlinePayList,
                  titleTextEditingController:
                      controller.onlinePayTitleTextEditingController,
                  priceTextEditingController:
                      controller.onlinePayPriceTextEditingController),
            ),
          );

          if (result == true) {}
        });
  }

  Widget _cashItem() {
    return FactorUnofficialSpecificationSelectItem(
        topTextFormFieldLabel: 'عنوان هزینه',
        bottomTextFormFieldLabel: 'قیمت',
        titleEdit: 'ویرایش پول نقد',
        topTextEditingController: controller.cashTitleTextEditingController,
        bottomTextEditingController: controller.cashPriceTextEditingController,
        itemList: controller.cashList,
        hasBottomItem: true,
        icon: const Icon(Icons.price_change_outlined),
        title: 'پرداخت نقدی ',
        bracesWord: 'پول نقد و ...',
        onTap: () async {
          controller.cashPriceTextEditingController.clear();
          controller.cashTitleTextEditingController.clear();
          final result = await Get.dialog(
            FactorUnofficialSpecificationDialog(
              topTextFormFieldLabel: 'عنوان هزینه',
              bottomTextFormFieldLabel: 'قیمت',
              title: 'افزودن پول نقد',
              titleButton: 'افزودن',
              topTextEditingController:
                  controller.cashTitleTextEditingController,
              bottomTextEditingController:
                  controller.cashPriceTextEditingController,
              buttonOnTap: () => controller.buttonOnTapItem(
                  listItem: controller.cashList,
                  titleTextEditingController:
                      controller.cashTitleTextEditingController,
                  priceTextEditingController:
                      controller.cashPriceTextEditingController),
            ),
          );

          if (result == true) {}
        });
  }

  Widget _cartItem() {
    return FactorUnofficialSpecificationSelectItem(
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        textInputType: TextInputType.phone,
        topTextFormFieldLabel: 'شماره پیگیری',
        bottomTextFormFieldLabel: 'قیمت',
        titleEdit: 'ویرایش پرداخت کارتی',
        topTextEditingController: controller.cartTitleTextEditingController,
        bottomTextEditingController: controller.cartPriceTextEditingController,
        itemList: controller.cartList,
        hasBottomItem: true,
        hasCustomBeforeTitle: true,
        customBeforeTitle: 'شماره پیگیری',
        icon: const Icon(Icons.price_change_outlined),
        title: 'پرداخت کارتی ',
        bracesWord: 'کارت بانکی و پوز و...',
        onTap: () async {
          controller.cartPriceTextEditingController.clear();
          controller.cartTitleTextEditingController.clear();
          final result = await Get.dialog(
            FactorUnofficialSpecificationDialog(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              textInputType: TextInputType.phone,
              topTextFormFieldLabel: 'شماره پیگیری',
              bottomTextFormFieldLabel: 'قیمت',
              title: 'افزودن پرداخت کارتی',
              titleButton: 'افزودن',
              topTextEditingController:
                  controller.cartTitleTextEditingController,
              bottomTextEditingController:
                  controller.cartPriceTextEditingController,
              buttonOnTap: () => controller.buttonOnTapItem(
                  listItem: controller.cartList,
                  titleTextEditingController:
                      controller.cartTitleTextEditingController,
                  priceTextEditingController:
                      controller.cartPriceTextEditingController),
            ),
          );

          if (result == true) {}
        });
  }

  Widget _excessCostItem() {
    return FactorUnofficialSpecificationSelectItem(
      topTextFormFieldLabel: 'عنوان هزینه',
      bottomTextFormFieldLabel: 'قیمت',
      titleEdit: 'ویرایش هزینه مازاد',
      topTextEditingController: controller.excessCostTitleTextEditingController,
      bottomTextEditingController:
          controller.excessCostPriceTextEditingController,
      itemList: controller.excessCostList,
      hasBottomItem: true,
      icon: const Icon(Icons.price_change_outlined),
      title: 'هزینه مازاد ',
      bracesWord: 'هزینه ارسال و ...',
      onTap: () async {
        controller.excessCostPriceTextEditingController.clear();
        controller.excessCostTitleTextEditingController.clear();
        final result = await Get.dialog(
          FactorUnofficialSpecificationDialog(
            titleButton: 'افزودن',
            topTextFormFieldLabel: 'عنوان هزینه',
            bottomTextFormFieldLabel: 'قیمت',
            title: 'افزودن هزینه مازاد',
            topTextEditingController:
                controller.excessCostTitleTextEditingController,
            bottomTextEditingController:
                controller.excessCostPriceTextEditingController,
            buttonOnTap: () => controller.buttonOnTapItem(
                listItem: controller.excessCostList,
                titleTextEditingController:
                    controller.excessCostTitleTextEditingController,
                priceTextEditingController:
                    controller.excessCostPriceTextEditingController),
          ),
        );

        if (result == true) {}
      },
    );
  }

  Widget _bottomNavigationBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: heightBottomSheet(),
      child: Wrap(
        children: [
          InkWell(
            child: BottomSheetTotalPriceWidget(
              bottomButtonOnTap: () async {
                final pdfView = await _createPdf();

                Get.to(ShowPdfView(pdfView: pdfView));
              },
              taxation: controller.taxation,
              discount: controller.discount,
              totalPrice: controller.totalPrice,
              totalWordPrice: controller.totalWordPrice,
              onTap: () {
                controller.isExpandedBottomSheet.value =
                    !controller.isExpandedBottomSheet.value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _createPdf() async {
    PdfDocument pdfDocument = PdfDocument();
    final page = pdfDocument.pages.add();
    page.graphics.drawString(
        'pedrammojarad', PdfStandardFont(PdfFontFamily.courier, 30));

    final List<int> pdfBytes = pdfDocument.save();
    pdfDocument.dispose();

    final Uint8List pdfView = Uint8List.fromList(pdfBytes);
    _pathFile(pdfView);
    return pdfView;
  }

  Future<void> _pathFile(Uint8List pdfView) async {
    if (kIsWeb) {
      await Printing.sharePdf(
        bytes: pdfView,
        filename: 'my-document.pdf',
      );
    } else {
      MimeType type = MimeType.PDF;
      await FileSaver.instance.saveAs("File", pdfView, "pdf", type);
    }
  }

  Widget _floatingActionButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: 30,
        height: 30,
        child: FloatingActionButton(
            onPressed: () {
              controller.isExpandedBottomSheet.value =
                  !controller.isExpandedBottomSheet.value;
            },
            child: FactorExpandIcon(
              isExpanded: controller.isExpandedBottomSheet.value,
              color: Colors.white,
            )),
      ),
    );
  }

  Widget _headerFactor(BuildContext context) {
    return Container(
      color: Colors.black,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Constants.smallVerticalSpacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'فاکتور فروش',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 37),
                ),
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ],
            ),
            Constants.largeVerticalSpacer,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    'تاریخ فاکتور : 1399/10/14',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 30),
                  child: Text(
                    '#1561',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            Constants.smallVerticalSpacer,
          ],
        ),
      ),
    );
  }

  double heightBottomSheet() {
    if (controller.factorUnofficialItemList.isEmpty) {
      return 0;
    } else if (controller.isExpandedBottomSheet.value) {
      return 225;
    } else {
      return 50;
    }
  }

  Map arguments(
      {required RxList<FactorUnofficialItemViewModel> factorUnofficialItemList,
      required String totalPrice,
      required String totalWordPrice,
      required String discount,
      required String taxation}) {
    final map = {};
    map['factorUnofficialItemList'] = factorUnofficialItemList;
    map['totalPrice'] = totalPrice;
    map['totalWordPrice'] = totalWordPrice;
    map['discount'] = discount;
    map['taxation'] = taxation;
    return map;
  }
}
