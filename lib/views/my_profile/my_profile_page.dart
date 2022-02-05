import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/my_profile/my_profile_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/more/widgets/signature_bottom_sheet/signature_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/square_card_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MyProfileController>(() => MyProfileController());
    return Scaffold(
      appBar: const FactorAppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            'مشخصات من',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              _profileHeaderSwitch(),
              Constants.mediumVerticalSpacer,
              if (controller.isLegal.value) _legalItems() else _unLegalItems(),
              Constants.mediumVerticalSpacer,
              _sealAndSignature(),
              Constants.largeVerticalSpacer,
              _button(),
              Constants.largeVerticalSpacer,
            ],
          ),
        );
      }),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: CustomBorderButton(
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _sealAndSignature() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: SquareCardBorder(
              isShowSignature: controller.isShowSignature.value,
              signatureIcon: controller.signatureIcon.value,
              icon: Image.asset(
                signatureIcon,
                width: MediaQuery.of(Get.context!).size.width / 2,
                height: MediaQuery.of(Get.context!).size.height / 8,
                fit: BoxFit.contain,
              ),
              title: Text(controller.signatureIcon.value == null
                  ? 'افزودن امضا'
                  : 'تغییر امضا'),
              onTap: () async {
                final result = await showModalBottomSheet<Uint8List>(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        30,
                      ),
                    ),
                  ),
                  context: Get.context!,
                  builder: (context) {
                    return SignatureBottomSheet();
                  },
                );
                if (result != null) {
                  print(result);
                  controller.isShowSignature.value = true;
                  controller.signatureIcon.value = result;
                }
              },
            )),

            Constants.mediumHorizontalSpacer,
            Expanded(
                child: SquareCardBorder(
              title: const Text('افزودن مهر'),
              icon: Image.asset(
                sealIcon,
                width: MediaQuery.of(Get.context!).size.width / 2,
                height: MediaQuery.of(Get.context!).size.height / 8,
                fit: BoxFit.contain,
              ),
            )),

            // CardIconWidget(onTap: () {}, title: 'افزودن مهر', icon: signatureIcon),
          ],
        ),
      );
    });
  }

  Widget _unLegalItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          FactorTextFormField(
            width: double.infinity,
            labelText: 'نام',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'نام خانوادگی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'شماره همراه',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'کدملی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'آدرس',
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _legalItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: const [
          FactorTextFormField(
            width: double.infinity,
            labelText: 'نام شخصیت حقوقی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'نوع شخصیت حقوقی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'شناسه ملی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'کد اقتصادی',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'شماره ثبت',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'تاریخ ثبت',
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'محل ثبت',
          ),
        ],
      ),
    );
  }

  Widget _profileHeaderSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          enabled: !controller.isLegal.value,
          loop: controller.loopLegal.value,
          baseColor: Colors.black,
          highlightColor: Colors.white,
          child: const Text(
            'حقیقی',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.scale(
          scale: 1.2,
          child: Switch(
            activeColor: Colors.black,
            inactiveThumbColor: Colors.black,
            inactiveTrackColor: Colors.black45,
            value: controller.isLegal.value,
            onChanged: (value) {
              controller.isLegal.value = value;
            },
          ),
        ),
        Shimmer.fromColors(
          enabled: controller.isLegal.value,
          loop: controller.loopLegal.value,
          baseColor: Colors.black,
          highlightColor: Colors.white,
          child: const Text(
            'حقوقی',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
