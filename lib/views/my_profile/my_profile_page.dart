import 'dart:typed_data';
import 'package:factor_flutter_mobile/controllers/my_profile/my_profile_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/core/utils/factor_validation/form_feild_validation.dart';
import 'package:factor_flutter_mobile/views/more/widgets/signature_bottom_sheet/signature_bottom_sheet.dart';
import 'package:factor_flutter_mobile/views/my_profile/widgets/my_profile_image_card.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/custom_text_form_field.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_button.dart';
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
      appBar: FactorAppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'مشخصات من',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            children: [
              _profileHeaderSwitch(),
              Constants.mediumVerticalSpacer,
              if (controller.isHaghighi.value)
                Form(
                    key: controller.haghighiFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: _unLegalItems(context))
              else
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: controller.hoghoghiFormKey,
                    child: _legalItems()),
              Constants.largeVerticalSpacer,
              _button(),
              Constants.largeVerticalSpacer,
            ],
          ),
        );
      }),
    );
  }

  Widget _signature(BuildContext context) {
    return MyProfileImageCard(
      icon: signatureIcon,
      isShowUint8List: controller.isShowSignature.value,
      title: 'افزودن امضا',
      editTitle: 'تغییر امضا',
      uint8ListImage: controller.uint8ListSignature.value,
      removeUint8ListOnTap: () => controller.removeUint8ListButton(
          title: 'حذف امضا',
          message: 'برای حذف امضا دکمه حذف x رو بفشار',
          isShow: controller.isShowSignature,
          uint8List: controller.uint8ListSignature),
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
            return const SignatureBottomSheet();
          },
        );
        if (result != null) {
          controller.isShowSignature.value = true;
          controller.uint8ListSignature.value = result;
        }
      },
    );
  }

  Widget _signatureHoghoghi() {
    return MyProfileImageCard(
      icon: signatureIcon,
      isShowUint8List: controller.isShowSignatureHoghoghi.value,
      title: 'افزودن امضا',
      editTitle: 'تغییر امضا',
      uint8ListImage: controller.uint8ListSignatureHoghoghi.value,
      removeUint8ListOnTap: () => controller.removeUint8ListButton(
          title: 'حذف امضا',
          message: 'برای حذف امضا دکمه حذف x رو بفشار',
          isShow: controller.isShowSignatureHoghoghi,
          uint8List: controller.uint8ListSignatureHoghoghi),
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
            return const SignatureBottomSheet();
          },
        );
        if (result != null) {
          controller.isShowSignatureHoghoghi.value = true;
          controller.uint8ListSignatureHoghoghi.value = result;
        }
      },
    );
  }

  Widget _button() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 20, start: 20, bottom: 20),
      child: SizedBox(
        width: double.infinity,
        // height: 50,
        child: FactorButton.elevated(
          titleButton: 'ثبت',
          onPressed: controller.save,
        ),
      ),
    );
  }

  Widget _sealAndLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: MyProfileImageCard(
          icon: logoDesignIcon,
          isShowUint8List: controller.isShowLogoImage.value,
          title: 'افزودن لوگو',
          editTitle: 'تغییر لوگو',
          uint8ListImage: controller.uint8ListLogoImage.value,
          onTap: () => controller.logoTap(Get.context!),
          removeUint8ListOnTap: () => controller.removeUint8ListButton(
              title: 'حذف لوگو',
              message: 'برای حذف لوگو دکمه حذف x رو بفشار',
              isShow: controller.isShowLogoImage,
              uint8List: controller.uint8ListLogoImage),
        )),
        Constants.mediumHorizontalSpacer,
        Expanded(
          child: MyProfileImageCard(
            icon: sealIcon,
            title: 'افزودن مهر',
            editTitle: 'تغییر مهر',
            isShowUint8List: controller.isShowSealImage.value,
            onTap: controller.sealOnTap,
            uint8ListImage: controller.uint8ListSealImage.value,
            removeUint8ListOnTap: () => controller.removeUint8ListButton(
                title: 'حذف مهر',
                message: 'برای حذف مهر دکمه حذف x رو بفشار',
                isShow: controller.isShowSealImage,
                uint8List: controller.uint8ListSealImage),
          ),
        ),
      ],
    );
  }

  Widget _sealAndLogoHoghoghi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: MyProfileImageCard(
            icon: logoDesignIcon,
            isShowUint8List: controller.isShowLogoHoghoghiImage.value,
            title: 'افزودن لوگو',
            editTitle: 'تغییر لوگو',
            onTap: controller.logoHoghoghiTap,
            uint8ListImage: controller.uint8ListLogoHoghoghiImage.value,
            removeUint8ListOnTap: () => controller.removeUint8ListButton(
                title: 'حذف لوگو',
                message: 'برای حذف لوگو دکمه حذف x رو بفشار',
                isShow: controller.isShowLogoHoghoghiImage,
                uint8List: controller.uint8ListLogoHoghoghiImage),
          ),
        ),
        Constants.mediumHorizontalSpacer,
        Expanded(
            child: MyProfileImageCard(
          icon: sealIcon,
          isShowUint8List: controller.isShowSealHoghoghiImage.value,
          title: 'افزودن مهر',
          editTitle: 'تغییر مهر',
          uint8ListImage: controller.uint8ListSealHoghoghiImage.value,
          onTap: controller.sealHoghoghiOnTap,
          removeUint8ListOnTap: () => controller.removeUint8ListButton(
              title: 'حذف مهر',
              message: 'برای حذف مهر دکمه حذف x رو بفشار',
              isShow: controller.isShowSealHoghoghiImage,
              uint8List: controller.uint8ListSealHoghoghiImage),
        )),
      ],
    );
  }

  Widget _unLegalItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomTextFormField(
            autofocus: false,
            labelText: 'نام و نام خانوادگی',
            textEditingController: controller.fullNameTextEditingController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(25),
            ],
            validatorTextField: emptyValidator('نام و نام خانوادگی'),
          ),
          CustomTextFormField(
            autofocus: false,
            labelText: 'کدملی',
            textEditingController: controller.nationalCodeTextEditingController,
            prefixIcon: const Icon(Icons.confirmation_num_outlined),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 10,
            textInputType: TextInputType.phone,
          ),
          CustomTextFormField(
              autofocus: false,
              labelText: 'شماره تماس',
              textEditingController: controller.mobileTextEditingController,
              prefixIcon: const Icon(Icons.phone),
              maxLength: 11,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validatorTextField: emptyValidator('شماره تماس'),
              textInputType: TextInputType.phone),
          CustomTextFormField(
              autofocus: false,
              maxLines: 3,
              labelText: 'آدرس',
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              textEditingController: controller.addressTextEditingController,
              prefixIcon: const Icon(Icons.add_location_outlined)),
          Constants.mediumVerticalSpacer,
          _sealAndLogo(),
          Constants.largeVerticalSpacer,
          _signature(context),
        ],
      ),
    );
  }

  Widget _legalItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomTextFormField(
            prefixIcon: const Icon(Icons.apartment),
            labelText: 'نام شرکت',
            textEditingController: controller.companyNameTextEditingController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
            ],
            validatorTextField: emptyValidator('نام شرکت'),
          ),
          CustomTextFormField(
            autofocus: false,
            labelText: 'شناسه ملی شرکت',
            textEditingController:
                controller.nationalCodeCompanyTextEditingController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 11,
            prefixIcon: const Icon(Icons.insert_drive_file_outlined),
            textInputType: TextInputType.phone,
          ),
          CustomTextFormField(
            prefixIcon: const Icon(Icons.phone),
            labelText: 'شماره تماس',
            textEditingController:
                controller.mobileTextHoghoghiEditingController,
            maxLength: 11,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInputType: TextInputType.phone,
            validatorTextField: emptyValidator('شماره تماس'),
          ),
          CustomTextFormField(
              maxLines: 3,
              autofocus: false,
              prefixIcon: const Icon(Icons.add_location_outlined),
              labelText: 'آدرس',
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              textEditingController:
                  controller.addressTextHoghohgiEditingController),
          Constants.mediumVerticalSpacer,
          _sealAndLogoHoghoghi(),
          Constants.largeVerticalSpacer,
          _signatureHoghoghi(),
        ],
      ),
    );
  }

  Widget _profileHeaderSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          enabled: !controller.isHaghighi.value,
          loop: controller.loopLegal.value,
          baseColor: Theme.of(Get.context!).colorScheme.secondary,
          highlightColor: Theme.of(Get.context!).primaryColor,
          child: TextButton(
              onPressed: () {
                controller.isHaghighi.value = false;
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
        Transform.scale(
          scale: 1.2,
          child: Switch(
            activeColor: Theme.of(Get.context!).colorScheme.secondary,
            inactiveThumbColor: Theme.of(Get.context!).colorScheme.secondary,
            inactiveTrackColor:
                Theme.of(Get.context!).colorScheme.secondary.withOpacity(.5),
            value: controller.isHaghighi.value,
            onChanged: (value) {
              controller.isHaghighi.value = value;
            },
          ),
        ),
        Shimmer.fromColors(
          enabled: controller.isHaghighi.value,
          loop: controller.loopLegal.value,
          baseColor: Theme.of(Get.context!).colorScheme.secondary,
          highlightColor: Theme.of(Get.context!).primaryColor,
          child: TextButton(
            onPressed: () {
              controller.isHaghighi.value = true;
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
      ],
    );
  }
}
