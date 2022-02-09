import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/haghighi_view_model/haghighi_view_model.dart';
import 'package:factor_flutter_mobile/models/hoghoghi_view_model/hoghoghi_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/image_picker/camera_gallery_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initSharedPreferences();
  }

  RxBool loadingSignature = false.obs;

  RxBool isLegal = false.obs;
  RxInt loopLegal = 1.obs;
  RxBool isShowSignature = false.obs;
  RxBool isDeleteCompleteSignature = false.obs;
  RxBool isShowSealImage = false.obs;
  RxBool isShowLogoImage = false.obs;
  final Uuid uuid = const Uuid();
  Rxn<Uint8List> uint8ListSignature = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListSealImage = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListLogoImage = Rxn<Uint8List>();
  Rxn<HaghighiViewModel> haghighiViewModel = Rxn<HaghighiViewModel>();
  Rxn<HoghoghiViewModel> hoghoghiViewModel = Rxn<HoghoghiViewModel>();

  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
  TextEditingController nationalCodeTextEditingController =
      TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController companyNameTextEditingController =
      TextEditingController();
  TextEditingController nationalCodeCompanyTextEditingController =
      TextEditingController();
  TextEditingController registrationIDTextEditingController =
      TextEditingController();

  HaghighiViewModel get _haghighiDto {
    return HaghighiViewModel(
        address: addressTextEditingController.text.isEmpty
            ? ''
            : addressTextEditingController.text,
        mobileNumber: mobileTextEditingController.text.isEmpty
            ? ''
            : mobileTextEditingController.text,
        logoUint8List: uint8ListLogoImage.value == null
            ? ''
            : base64Encode(uint8ListLogoImage.value!),
        sealUint8List: uint8ListSealImage.value == null
            ? ''
            : base64Encode(uint8ListSealImage.value!),
        signatureUint8List: uint8ListSignature.value == null
            ? ''
            : base64Encode(uint8ListSignature.value!),
        id: uuid.v4(),
        firstName: firstNameTextEditingController.text.isEmpty
            ? ''
            : firstNameTextEditingController.text,
        lastName: lastNameTextEditingController.text.isEmpty
            ? ''
            : lastNameTextEditingController.text,
        nationalCode: nationalCodeTextEditingController.text.isEmpty
            ? ''
            : nationalCodeTextEditingController.text);
  }

  HoghoghiViewModel get _hoghoghiDto {
    return HoghoghiViewModel(
        address: addressTextEditingController.text.isEmpty
            ? ''
            : addressTextEditingController.text,
        mobileNumber: mobileTextEditingController.text.isEmpty
            ? ''
            : mobileTextEditingController.text,
        logoUint8List: uint8ListLogoImage.value == null
            ? ''
            : base64Encode(uint8ListLogoImage.value!),
        sealUint8List: uint8ListSealImage.value == null
            ? ''
            : base64Encode(uint8ListSealImage.value!),
        signatureUint8List: uint8ListSignature.value == null
            ? ''
            : base64Encode(uint8ListSignature.value!),
        id: uuid.v4(),
        companyName: companyNameTextEditingController.text.isEmpty
            ? ''
            : companyNameTextEditingController.text,
        nationalCodeCompany:
            nationalCodeCompanyTextEditingController.text.isEmpty
                ? ''
                : nationalCodeCompanyTextEditingController.text,
        registrationID: registrationIDTextEditingController.text.isEmpty
            ? ''
            : registrationIDTextEditingController.text);
  }

  void save() {
    if (!isLegal.value) {
      saveHaghighiProfile();
    } else {
      saveHoghoghiProfile();
    }

    Get.back();
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadHaghighiData();
  }

  void loadHoghoghiData() {
    String hoghoghiData =
        sharedPreferences.getString(hoghoghiSharedPreferencesKey) ?? '';

    if (hoghoghiData.isNotEmpty) {
      hoghoghiViewModel.value =
          HoghoghiViewModel.fromJson(jsonDecode(hoghoghiData));

      loadHoghoghiReplaceItem();
      log(hoghoghiData);
    }
  }

  void loadHaghighiData() {
    String haghighiData =
        sharedPreferences.getString(haghighiSharedPreferencesKey) ?? '';

    if (haghighiData.isNotEmpty) {
      haghighiViewModel.value =
          HaghighiViewModel.fromJson(jsonDecode(haghighiData));
      loadHaghighiReplaceItem();
    }
  }

  void loadHoghoghiReplaceItem() {
    companyNameTextEditingController.text =
        hoghoghiViewModel.value!.companyName;
    nationalCodeCompanyTextEditingController.text =
        hoghoghiViewModel.value!.nationalCodeCompany;

    registrationIDTextEditingController.text =
        hoghoghiViewModel.value!.registrationID;

    mobileTextEditingController.text = hoghoghiViewModel.value!.mobileNumber;
    addressTextEditingController.text = hoghoghiViewModel.value!.address;
    uint8ListSealImage(base64Decode(hoghoghiViewModel.value!.sealUint8List));
    if (uint8ListSealImage.value != null) {
      isShowSealImage.value = true;
    }
    uint8ListLogoImage(base64Decode(hoghoghiViewModel.value!.logoUint8List));
    if (uint8ListLogoImage.value != null) {
      isShowLogoImage.value = true;
    }
    uint8ListSignature(
        base64Decode(hoghoghiViewModel.value!.signatureUint8List));
    if (uint8ListSignature.value != null) {
      isShowSignature.value = true;
    }
  }

  void loadHaghighiReplaceItem() {
    firstNameTextEditingController.text = haghighiViewModel.value!.firstName;
    lastNameTextEditingController.text = haghighiViewModel.value!.lastName;
    nationalCodeTextEditingController.text =
        haghighiViewModel.value!.nationalCode;
    mobileTextEditingController.text = haghighiViewModel.value!.mobileNumber;
    addressTextEditingController.text = haghighiViewModel.value!.address;
    uint8ListSealImage(base64Decode(haghighiViewModel.value!.sealUint8List));
    if (uint8ListSealImage.value != null &&
        haghighiViewModel.value!.sealUint8List != '') {
      isShowSealImage.value = true;
    }
    uint8ListLogoImage(base64Decode(haghighiViewModel.value!.logoUint8List));
    if (uint8ListLogoImage.value != null &&
        haghighiViewModel.value!.logoUint8List != '') {
      isShowLogoImage.value = true;
    }
    uint8ListSignature(
        base64Decode(haghighiViewModel.value!.signatureUint8List));
    if (uint8ListSignature.value != null &&
        haghighiViewModel.value!.signatureUint8List != '') {
      isShowSignature.value = true;
    }
  }

  void saveHaghighiData() {
    String myProfileData = json.encode(_haghighiDto.toJson());
    sharedPreferences.setString(haghighiSharedPreferencesKey, myProfileData);
  }

  void saveHaghighiProfile() {
    saveHaghighiData();
  }

  void saveHoghoghiData() {
    String myProfileData = json.encode(_hoghoghiDto.toJson());
    sharedPreferences.setString(hoghoghiSharedPreferencesKey, myProfileData);
  }

  void saveHoghoghiProfile() {
    saveHoghoghiData();
  }

  void logoTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    CameraOrGalleryBottomSheet.chooseCameraOrGallery(
      Get.context!,
      cameraButtonFunction: () {
        Get.back();
        _getLogoImage(imageSource: ImageSource.camera);
      },
      galleryButtonFunction: () {
        Get.back();
        _getLogoImage(imageSource: ImageSource.gallery);
      },
    );
  }

  void sealOnTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    CameraOrGalleryBottomSheet.chooseCameraOrGallery(
      Get.context!,
      cameraButtonFunction: () {
        Get.back();
        _getSealImage(imageSource: ImageSource.camera);
      },
      galleryButtonFunction: () {
        Get.back();
        _getSealImage(imageSource: ImageSource.gallery);
      },
    );
  }

  Future _getSealImage({required ImageSource imageSource}) async {
    try {
      var imagePick = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (imagePick != null) {
        XFile imageFile = XFile(imagePick.path);

        Uint8List imageRaw = await imageFile.readAsBytes();
        uint8ListSealImage.value = imageRaw;
        if (lookupMimeType(imageFile.path, headerBytes: imageRaw)!
            .contains('image')) {
          isShowSealImage.value = true;
        } else {
          isShowSealImage.value = false;

          Get.snackbar(
            'خطا در عکس مهر',
            'لطفا عکس انتخاب کن',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'عکس مهر خالی',
          'عکس انتخاب نکردی',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      return uint8ListSealImage;
    } catch (e) {
      Get.snackbar(
        'خطا در عکس مهر',
        'مشکلی پیش اومده دوباره تلاش کن',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future _getLogoImage({required ImageSource imageSource}) async {
    try {
      var imagePick = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (imagePick != null) {
        XFile imageFile = XFile(imagePick.path);

        Uint8List imageRaw = await imageFile.readAsBytes();
        uint8ListLogoImage.value = imageRaw;
        if (lookupMimeType(imageFile.path, headerBytes: imageRaw)!
            .contains('image')) {
          isShowLogoImage.value = true;
        } else {
          isShowLogoImage.value = false;

          Get.snackbar(
            'خطا در عکس لوگو',
            'لطفا عکس انتخاب کن',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'عکس لوگو خالی',
          'عکس انتخاب نکردی',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      return uint8ListLogoImage;
    } catch (e) {
      Get.snackbar(
        'خطا در عکس لوگو',
        'مشکلی پیش اومده دوباره تلاش کن',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
