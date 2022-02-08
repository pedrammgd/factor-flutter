import 'dart:typed_data';

import 'package:factor_flutter_mobile/controllers/my_profile/my_profile_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/views/more/widgets/signature_bottom_sheet/signature_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/square_card_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class MyProfilePage extends GetView<MyProfileController> {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MyProfileController>(() => (MyProfileController()));
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
              Constants.largeVerticalSpacer,
              _button(),
              Constants.largeVerticalSpacer,
            ],
          ),
        );
      }),
    );
  }

  Widget _addressTextFormField() {
    return FactorTextFormField(
      hasBorder: true,
      controller: controller.addressTextEditingController,
      width: double.infinity,
      labelText: 'آدرس',
      textInputAction: TextInputAction.next,
      maxLines: 3,
    );
  }

  Widget _mobileNumberTextFormField() {
    return FactorTextFormField(
      controller: controller.mobileTextEditingController,
      width: double.infinity,
      validatorTextField:
          mobileNumberValidatorWithOutRequiredEmpty('شماره همراه'),
      labelText: 'شماره همراه',
      hasBorder: true,
      maxLength: 11,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      textInputAction: TextInputAction.next,
      textInputType: TextInputType.phone,
    );
  }

  Widget _logo() {
    return SquareCardBorder(
      title: Text(controller.uint8ListLogoImage.value == null
          ? 'افزودن لوگو'
          : 'تغییر لوگو'),
      removeUint8ListOnTap: () {
        controller.isShowLogoImage.value = false;
        controller.uint8ListLogoImage.value = null;
      },
      onTap: controller.logoTap,
      isShowUint8List: controller.isShowLogoImage.value,
      uint8ListImage: controller.uint8ListLogoImage.value,
      icon: Image.asset(
        sealIcon,
        width: MediaQuery.of(Get.context!).size.width / 2,
        height: MediaQuery.of(Get.context!).size.height / 8,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: CustomBorderButton(
          onPressed: controller.save,
        ),
      ),
    );
  }

  Widget _sealAndSignature() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: SquareCardBorder(
            removeUint8ListOnTap: () {
              controller.isShowSignature.value = false;
              controller.uint8ListSignature.value = null;
            },
            isShowUint8List: controller.isShowSignature.value,
            uint8ListImage: controller.uint8ListSignature.value,
            icon: Image.asset(
              signatureIcon,
              width: MediaQuery.of(Get.context!).size.width / 2,
              height: MediaQuery.of(Get.context!).size.height / 8,
              fit: BoxFit.contain,
            ),
            title: Text(controller.uint8ListSignature.value == null
                ? 'افزودن امضا'
                : 'تغییر امضا'),
            onTap: () async {
              FocusManager.instance.primaryFocus?.unfocus();
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
                controller.isShowSignature.value = true;
                controller.uint8ListSignature.value = result;
              }
            },
          )),
          Constants.mediumHorizontalSpacer,
          Expanded(
              child: SquareCardBorder(
            removeUint8ListOnTap: () {
              controller.isShowSealImage.value = false;
              controller.uint8ListSealImage.value = null;
            },
            isShowUint8List: controller.isShowSealImage.value,
            uint8ListImage: controller.uint8ListSealImage.value,
            title: Text(controller.uint8ListSealImage.value == null
                ? 'افزودن مهر'
                : 'تغییر مهر'),
            onTap: controller.sealOnTap,
            icon: Image.asset(
              sealIcon,
              width: MediaQuery.of(Get.context!).size.width / 2,
              height: MediaQuery.of(Get.context!).size.height / 8,
              fit: BoxFit.contain,
            ),
          )),
        ],
      );
    });
  }

  Widget _unLegalItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FactorTextFormField(
            controller: controller.firstNameTextEditingController,
            width: double.infinity,
            labelText: 'نام',
            hasBorder: true,
            textInputAction: TextInputAction.next,
          ),
          FactorTextFormField(
            controller: controller.lastNameTextEditingController,
            width: double.infinity,
            labelText: 'نام خانوادگی',
            hasBorder: true,
            textInputAction: TextInputAction.next,
          ),
          FactorTextFormField(
            controller: controller.nationalCodeTextEditingController,
            width: double.infinity,
            labelText: 'کدملی',
            hasBorder: true,
            maxLength: 10,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.phone,
            validatorTextField:
                nationalCodeValidatorWithOutRequiredEmpty('کدملی'),
          ),
          _mobileNumberTextFormField(),
          _addressTextFormField(),
          Constants.mediumVerticalSpacer,
          _sealAndSignature(),
          Constants.largeVerticalSpacer,
          _logo(),
        ],
      ),
    );
  }

  Widget _legalItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FactorTextFormField(
            width: double.infinity,
            labelText: 'نام شرکت',
            hasBorder: true,
            validatorTextField: emptyValidator('نام شرکت'),
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'شناسه ملی شرکت',
            hasBorder: true,
            validatorTextField: emptyValidator('شناسه ملی شرکت'),
          ),
          FactorTextFormField(
            width: double.infinity,
            labelText: 'شماره ثبت',
            hasBorder: true,
            validatorTextField: emptyValidator('شماره ثبت'),
          ),
          _mobileNumberTextFormField(),
          _addressTextFormField(),
          Constants.mediumVerticalSpacer,
          _sealAndSignature(),
          Constants.largeVerticalSpacer,
          _logo(),
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
          child: TextButton(
            onPressed: () {
              controller.isLegal.value = false;
            },
            child: const Text(
              'حقیقی',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
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
          child: TextButton(
              onPressed: () {
                controller.isLegal.value = true;
              },
              child: const Text(
                'حقوقی',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
      ],
    );
  }
}
