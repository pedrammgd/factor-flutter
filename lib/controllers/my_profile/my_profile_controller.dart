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

  RxBool loadingSignature = false.obs;

  RxBool isLegal = false.obs;
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
  Rxn<MyProfileViewModel> hoghoghiViewModel = Rxn<MyProfileViewModel>();
  GlobalKey<FormState> haghighiFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> hoghoghiFormKey = GlobalKey<FormState>();

  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController mobileTextHoghoghiEditingController =
      TextEditingController();
  TextEditingController firstNameTextEditingController =
      TextEditingController();
  TextEditingController lastNameTextEditingController = TextEditingController();
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
          isHaghighi: !isLegal.value,
          firstName: firstNameTextEditingController.text.isEmpty
              ? ''
              : firstNameTextEditingController.text,
          lastName: lastNameTextEditingController.text.isEmpty
              ? ''
              : lastNameTextEditingController.text,
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
          isHaghighi: !isLegal.value,
          address: addressTextHoghohgiEditingController.text.isEmpty
              ? ''
              : addressTextHoghohgiEditingController.text,
          mobileNumber: mobileTextHoghoghiEditingController.text.isEmpty
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
      logoUint8List: uint8ListLogoHoghoghiImage.value == null
          ? ''
          : base64Encode(uint8ListLogoHoghoghiImage.value!),
      sealUint8List: uint8ListSealHoghoghiImage.value == null
          ? ''
          : base64Encode(uint8ListSealHoghoghiImage.value!),
      signatureUint8List: uint8ListSignatureHoghoghi.value == null
          ? ''
          : base64Encode(uint8ListSignatureHoghoghi.value!),
    );
  }

  void save() {
    if (!isLegal.value) {
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

    Get.back();
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    loadHaghighiData();
    loadHoghoghiData();
  }

  void loadHoghoghiData() {
    String hoghoghiData =
        sharedPreferences.getString(hoghoghiSharedPreferencesKey) ?? '';

    if (hoghoghiData.isNotEmpty) {
      hoghoghiViewModel.value =
          MyProfileViewModel.fromJson(jsonDecode(hoghoghiData));

      log(hoghoghiData);
      loadHoghoghiReplaceItem();
    }
  }

  void loadHaghighiData() {
    String haghighiData =
        sharedPreferences.getString(haghighiSharedPreferencesKey) ?? '';

    if (haghighiData.isNotEmpty) {
      haghighiViewModel.value =
          MyProfileViewModel.fromJson(jsonDecode(haghighiData));
      log(haghighiData);
      loadHaghighiReplaceItem();
    }
  }

  void loadHoghoghiReplaceItem() {
    companyNameTextEditingController.text =
        hoghoghiViewModel.value!.personBasicInformationViewModel.companyName!;
    nationalCodeCompanyTextEditingController.text = hoghoghiViewModel
        .value!.personBasicInformationViewModel.nationalCodeCompany!;

    registrationIDTextEditingController.text = hoghoghiViewModel
        .value!.personBasicInformationViewModel.registrationID!;

    mobileTextHoghoghiEditingController.text =
        hoghoghiViewModel.value!.personBasicInformationViewModel.mobileNumber!;
    addressTextHoghohgiEditingController.text =
        hoghoghiViewModel.value!.personBasicInformationViewModel.address!;
    uint8ListSealHoghoghiImage(
        base64Decode(hoghoghiViewModel.value!.sealUint8List));
    if (uint8ListSealHoghoghiImage.value != null &&
        hoghoghiViewModel.value!.sealUint8List != '') {
      isShowSealHoghoghiImage.value = true;
    }
    uint8ListLogoHoghoghiImage(
        base64Decode(hoghoghiViewModel.value!.logoUint8List));
    if (uint8ListLogoHoghoghiImage.value != null &&
        hoghoghiViewModel.value!.logoUint8List != '') {
      isShowLogoHoghoghiImage.value = true;
    }
    uint8ListSignatureHoghoghi(
        base64Decode(hoghoghiViewModel.value!.signatureUint8List));
    if (uint8ListSignatureHoghoghi.value != null &&
        hoghoghiViewModel.value!.signatureUint8List != '') {
      isShowSignatureHoghoghi.value = true;
    }
  }

  void loadHaghighiReplaceItem() {
    firstNameTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.firstName!;
    lastNameTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.lastName!;
    nationalCodeTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.nationalCode!;
    mobileTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.mobileNumber!;
    addressTextEditingController.text =
        haghighiViewModel.value!.personBasicInformationViewModel.address!;
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
