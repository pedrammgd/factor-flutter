import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/my_profile_view_model/my_profile_view_model.dart';
import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';
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

  RxBool isHaghighi = true.obs;
  RxInt loopLegal = 1.obs;
  RxBool isShowSignature = false.obs;
  RxBool isShowSignatureHoghoghi = false.obs;
  RxBool isDeleteCompleteSignature = false.obs;
  RxBool isShowSealImage = false.obs;
  RxBool isShowSealHoghoghiImage = false.obs;
  RxBool isShowLogoImage = false.obs;
  RxBool isShowLogoHoghoghiImage = false.obs;
  final Uuid uuid = const Uuid();
  Rxn<Uint8List> uint8ListSignature = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListSignatureHoghoghi = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListSealImage = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListSealHoghoghiImage = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListLogoImage = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListLogoHoghoghiImage = Rxn<Uint8List>();
  Rxn<MyProfileViewModel> haghighiViewModel = Rxn<MyProfileViewModel>();

  GlobalKey<FormState> haghighiFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hoghoghiFormKey = GlobalKey<FormState>();

  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController mobileTextHoghoghiEditingController =
      TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController nationalCodeTextEditingController =
      TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController addressTextHoghohgiEditingController =
      TextEditingController();
  TextEditingController companyNameTextEditingController =
      TextEditingController();
  TextEditingController nationalCodeCompanyTextEditingController =
      TextEditingController();
  TextEditingController registrationIDTextEditingController =
      TextEditingController();

  MyProfileViewModel get _haghighiDto {
    return MyProfileViewModel(
      personBasicInformationViewModel: PersonBasicInformationViewModel(
          id: uuid.v4(),
          address: addressTextEditingController.text.isEmpty
              ? ''
              : addressTextEditingController.text,
          mobileNumber: mobileTextEditingController.text.isEmpty
              ? ''
              : mobileTextEditingController.text,
          isHaghighi: isHaghighi.value,
          fullName: fullNameTextEditingController.text.isEmpty
              ? ''
              : fullNameTextEditingController.text,
          nationalCode: nationalCodeTextEditingController.text.isEmpty
              ? ''
              : nationalCodeTextEditingController.text),
      logoUint8List: uint8ListLogoImage.value == null
          ? ''
          : base64Encode(uint8ListLogoImage.value!),
      sealUint8List: uint8ListSealImage.value == null
          ? ''
          : base64Encode(uint8ListSealImage.value!),
      signatureUint8List: uint8ListSignature.value == null
          ? ''
          : base64Encode(uint8ListSignature.value!),
    );
  }

  MyProfileViewModel get _hoghoghiDto {
    return MyProfileViewModel(
      personBasicInformationViewModel: PersonBasicInformationViewModel(
          isHaghighi: isHaghighi.value,
          addressHoghoghi: addressTextHoghohgiEditingController.text.isEmpty
              ? ''
              : addressTextHoghohgiEditingController.text,
          mobileNumberHoghoghi: mobileTextHoghoghiEditingController.text.isEmpty
              ? ''
              : mobileTextHoghoghiEditingController.text,
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
              : registrationIDTextEditingController.text),
      logoUint8ListHoghoghi: uint8ListLogoHoghoghiImage.value == null
          ? ''
          : base64Encode(uint8ListLogoHoghoghiImage.value!),
      sealUint8ListHoghoghi: uint8ListSealHoghoghiImage.value == null
          ? ''
          : base64Encode(uint8ListSealHoghoghiImage.value!),
      signatureUint8ListHoghoghi: uint8ListSignatureHoghoghi.value == null
          ? ''
          : base64Encode(uint8ListSignatureHoghoghi.value!),
    );
  }

  void save() {
    if (isHaghighi.value) {
      if (!haghighiFormKey.currentState!.validate()) {
        Get.snackbar(
          'مشکلی پیش اومده',
          'انگار بعضی از فیلد ها رو تکمیل نکردی یا اشتباه وارد کردی',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      saveHaghighiProfile();
    } else {
      if (!hoghoghiFormKey.currentState!.validate()) {
        Get.snackbar(
          'مشکلی پیش اومده',
          'انگار بعضی از فیلد ها رو تکمیل نکردی یا اشتباه وارد کردی',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      saveHoghoghiProfile();
    }

    Get.back(result: haghighiViewModel);
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadMyProfileData();
  }

  void loadMyProfileData() {
    String myProfileData =
        sharedPreferences.getString(myProfileSharedPreferencesKey) ?? '';

    if (myProfileData.isNotEmpty) {
      haghighiViewModel.value =
          MyProfileViewModel.fromJson(jsonDecode(myProfileData));
      log(myProfileData);
      loadMyProfileReplaceItem();
    }
  }

  void loadMyProfileReplaceItem() {
    isHaghighi.value =
        haghighiViewModel.value!.personBasicInformationViewModel.isHaghighi;
    companyNameTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.companyName ??
            '';
    mobileTextHoghoghiEditingController.text = haghighiViewModel
            .value!.personBasicInformationViewModel.mobileNumberHoghoghi ??
        '';
    nationalCodeCompanyTextEditingController.text = haghighiViewModel
            .value!.personBasicInformationViewModel.nationalCodeCompany ??
        '';

    registrationIDTextEditingController.text = haghighiViewModel
            .value!.personBasicInformationViewModel.registrationID ??
        '';
    addressTextHoghohgiEditingController.text = haghighiViewModel
            .value!.personBasicInformationViewModel.addressHoghoghi ??
        '';
    fullNameTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.fullName ?? '';
    nationalCodeTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.nationalCode ??
            '';
    mobileTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.mobileNumber ??
            '';
    addressTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.address ?? '';

    if (haghighiViewModel.value?.sealUint8List != null &&
        haghighiViewModel.value!.sealUint8List != '') {
      uint8ListSealImage(
          base64Decode(haghighiViewModel.value!.sealUint8List ?? ''));
      isShowSealImage.value = true;
    }

    if (haghighiViewModel.value?.sealUint8ListHoghoghi != null &&
        haghighiViewModel.value!.sealUint8ListHoghoghi != '') {
      uint8ListSealHoghoghiImage(
          base64Decode(haghighiViewModel.value!.sealUint8ListHoghoghi ?? ''));
      isShowSealHoghoghiImage.value = true;
    }

    if (haghighiViewModel.value?.logoUint8List != null &&
        haghighiViewModel.value!.logoUint8List != '') {
      uint8ListLogoImage(
          base64Decode(haghighiViewModel.value!.logoUint8List ?? ''));
      isShowLogoImage.value = true;
    }

    if (haghighiViewModel.value?.logoUint8ListHoghoghi != null &&
        haghighiViewModel.value!.logoUint8ListHoghoghi != '') {
      uint8ListLogoHoghoghiImage(
          base64Decode(haghighiViewModel.value!.logoUint8ListHoghoghi ?? ''));
      isShowLogoHoghoghiImage.value = true;
    }

    if (haghighiViewModel.value?.signatureUint8List != null &&
        haghighiViewModel.value!.signatureUint8List != '') {
      uint8ListSignature(
          base64Decode(haghighiViewModel.value!.signatureUint8List ?? ''));
      isShowSignature.value = true;
    }

    if (haghighiViewModel.value?.signatureUint8ListHoghoghi != null &&
        haghighiViewModel.value!.signatureUint8ListHoghoghi != '') {
      uint8ListSignatureHoghoghi(base64Decode(
          haghighiViewModel.value!.signatureUint8ListHoghoghi ?? ''));
      isShowSignatureHoghoghi.value = true;
    }
  }

  void saveHaghighiData() {
    String myProfileData = json.encode(_haghighiDto.toJson());
    sharedPreferences.setString(myProfileSharedPreferencesKey, myProfileData);
  }

  void saveHaghighiProfile() {
    saveHaghighiData();
  }

  void saveHoghoghiData() {
    String myProfileData = json.encode(_hoghoghiDto.toJson());
    sharedPreferences.setString(myProfileSharedPreferencesKey, myProfileData);
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

  void logoHoghoghiTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    CameraOrGalleryBottomSheet.chooseCameraOrGallery(
      Get.context!,
      cameraButtonFunction: () {
        Get.back();
        _getLogoHoghoghiImage(imageSource: ImageSource.camera);
      },
      galleryButtonFunction: () {
        Get.back();
        _getLogoHoghoghiImage(imageSource: ImageSource.gallery);
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

  void sealHoghoghiOnTap() {
    FocusManager.instance.primaryFocus?.unfocus();
    CameraOrGalleryBottomSheet.chooseCameraOrGallery(
      Get.context!,
      cameraButtonFunction: () {
        Get.back();
        _getSealHoghoghiImage(imageSource: ImageSource.camera);
      },
      galleryButtonFunction: () {
        Get.back();
        _getSealHoghoghiImage(imageSource: ImageSource.gallery);
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

  Future _getSealHoghoghiImage({required ImageSource imageSource}) async {
    try {
      var imagePick = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (imagePick != null) {
        XFile imageFile = XFile(imagePick.path);

        Uint8List imageRaw = await imageFile.readAsBytes();
        uint8ListSealHoghoghiImage.value = imageRaw;
        if (lookupMimeType(imageFile.path, headerBytes: imageRaw)!
            .contains('image')) {
          isShowSealHoghoghiImage.value = true;
        } else {
          isShowSealHoghoghiImage.value = false;

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

      return uint8ListSealHoghoghiImage;
    } catch (e) {
      Get.snackbar(
        'خطا در عکس مهر',
        'مشکلی پیش اومده دوباره تلاش کن',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future _getLogoHoghoghiImage({required ImageSource imageSource}) async {
    try {
      var imagePick = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (imagePick != null) {
        XFile imageFile = XFile(imagePick.path);

        Uint8List imageRaw = await imageFile.readAsBytes();
        uint8ListLogoHoghoghiImage.value = imageRaw;
        if (lookupMimeType(imageFile.path, headerBytes: imageRaw)!
            .contains('image')) {
          isShowLogoHoghoghiImage.value = true;
        } else {
          isShowLogoHoghoghiImage.value = false;

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

      return uint8ListLogoHoghoghiImage;
    } catch (e) {
      Get.snackbar(
        'خطا در عکس لوگو',
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

  void removeUint8ListButton(
      {required RxBool isShow,
      required Rxn<Uint8List> uint8List,
      String title = 'عنوان',
      String message = 'پیام'}) {
    Get.snackbar(title, message,
        duration: const Duration(milliseconds: 3000),
        mainButton: TextButton(
            onPressed: () {
              Get.back();
              isShow.value = false;
              uint8List.value = null;
            },
            child: Row(
              children: const [
                Text(
                  'حذف',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Icon(
                  Icons.clear,
                  color: Colors.red,
                  size: 15,
                ),
              ],
            )));
  }
}
