import 'dart:typed_data';
import 'dart:ui';

import 'package:factor_flutter_mobile/controllers/factor_unofficial_specification/factor_unofficial_specification_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/router/factor_pages.dart';
import 'package:factor_flutter_mobile/models/factor_unofficial_item_view_model/factor_unofficial_item_view_model.dart';
import 'package:factor_flutter_mobile/models/specification_cost_view_model/specification_cost_view_model.dart';
import 'package:factor_flutter_mobile/views/buyer/buyer_page.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial_specification/widgets/factor_unofficial_specification_dialog.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/bottom_sheet_total_price_widget.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_factor_divider.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/expandable/factor_expandable.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/show_pdf/show_pdf_view.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            children: [
              _headerFactor(context),
              _factorSelectButton(
                isSelectedName: controller.isMyProfileItemNull.value,
                selectedText: controller.myProfileItem.value !=
                        null?.personBasicInformationViewModel.isHaghighi
                    ? controller.myProfileItem.value
                            ?.personBasicInformationViewModel.fullName ??
                        ''
                    : controller.myProfileItem.value
                            ?.personBasicInformationViewModel.companyName ??
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
              ),
              Constants.largeVerticalSpacer,
              _factorSelectButton(
                  title: 'طرف حساب ',
                  bracesWord: 'مشتری',
                  isSelectedName: controller.isSelectedBuyerName.value,
                  selectedText: controller.buyerItem.value
                          ?.personBasicInformationViewModel.fullName ??
                      controller.buyerItem.value
                          ?.personBasicInformationViewModel.companyName ??
                      '',
                  onTap: () async {
                    final result = await Get.toNamed(FactorRoutes.buyer,
                        arguments: const BuyerPage()
                            .arguments(isEnterFromSpecificFactor: true));
                    if (result != null) {
                      controller.buyerItem.value = result;
                      controller.isSelectedBuyerName.value = true;
                    }
                  }),
              Constants.largeVerticalSpacer,
              _factorSelectButton(
                itemList: controller.excessCostList,
                hasBottomItem: true,
                icon: const Icon(Icons.price_change_outlined),
                title: 'هزینه مازاد ',
                bracesWord: 'هزینه ارسال و ...',
                onTap: () async {
                  final result = await Get.dialog(
                    FactorUnofficialSpecificationDialog(
                      topTextEditingController:
                          controller.excessCostTitleTextEditingController,
                      bottomTextEditingController:
                          controller.excessCostPriceTextEditingController,
                      buttonOnTap: () {
                        controller.excessCostList.add(
                            SpecificationCostViewModel(
                                id: '',
                                price: controller
                                    .excessCostPriceTextEditingController.text,
                                title: controller
                                    .excessCostTitleTextEditingController
                                    .text));
                        Get.back();
                      },
                    ),
                  );

                  if (result == true) {
                    print('eee');
                  }
                },
              ),
              _factorSelectButton(
                  hasBottomItem: false,
                  icon: const Icon(Icons.price_change_outlined),
                  title: 'پرداخت نقدی ',
                  bracesWord: 'پول نقد'),
              _factorSelectButton(
                  hasBottomItem: false,
                  icon: const Icon(Icons.price_change_outlined),
                  title: 'پرداخت کارتی ',
                  bracesWord: 'کارت بانکی و پوز و...'),
              _factorSelectButton(
                  hasBottomItem: false,
                  icon: const Icon(Icons.price_change_outlined),
                  title: 'پرداخت آنلاین ',
                  bracesWord: 'اینترنتی و ...'),
              _factorSelectButton(
                  hasBottomItem: false,
                  icon: const Icon(Icons.price_change_outlined),
                  title: 'پرداخت چکی ',
                  bracesWord: 'چک و سفته ...'),
              Constants.largeVerticalSpacer,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _floatingActionButton(),
        bottomNavigationBar: _bottomNavigationBar(),
      );
    });
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

  Widget _factorSelectButton({
    required String title,
    required String bracesWord,
    Widget icon = const Icon(Icons.person_add_alt),
    bool hasBottomItem = false,
    Function()? onTap,
    bool isSelectedName = false,
    String selectedText = '',
    RxList<SpecificationCostViewModel>? itemList,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.largeVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Constants.xLargeHorizontalSpacer,
              Expanded(
                  child: RichText(
                text: TextSpan(
                  text: title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'IRANSans'),
                  children: <TextSpan>[
                    TextSpan(
                        text: '($bracesWord)',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            fontFamily: 'IRANSans')),
                  ],
                ),
              )),
              Constants.xLargeHorizontalSpacer,
              if (isSelectedName)
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      selectedText,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              else
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    icon,
                    Constants.smallHorizontalSpacer,
                    const Text('افزودن')
                  ],
                )),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.largeVerticalSpacer,
          if (hasBottomItem)
            ListView.builder(
              itemCount: itemList?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Column(
                children: [
                  // Constants.mediumVerticalSpacer,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 32),
                        child: Text(
                            '${itemList![index].title} : ${itemList[index].price} ریال '),
                        // child: Text('  : $price  ریال $titleCost'),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: 20,
                          start: 20,
                        ),
                        child: Icon(Icons.remove_circle_outline),
                      ),
                    ],
                  ),
                  Constants.smallVerticalSpacer,
                ],
              ),
            ),
          const CustomFactorDivider(
            height: 0,
            thickness: 1,
          ),
          Constants.largeVerticalSpacer,
        ],
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
