import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

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
  RxBool isShowSealImage = false.obs;
  RxBool isShowLogoImage = false.obs;
  final Uuid uuid = const Uuid();
  Rxn<Uint8List> uint8ListSignature = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListSealImage = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListLogoImage = Rxn<Uint8List>();
  Rxn<HaghighiViewModel> haghighiViewModel = Rxn<HaghighiViewModel>();

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
            : uint8ListLogoImage.value!.toString(),
        sealUint8List: uint8ListSealImage.value == null
            ? ''
            : uint8ListSealImage.value!.toString(),
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
        address: addressTextEditingController.text,
        mobileNumber: mobileTextEditingController.text,
        logoUint8List: uint8ListLogoImage.value!.toString(),
        sealUint8List: uint8ListSealImage.value!.toString(),
        signatureUint8List: base64Encode(uint8ListSignature.value!),
        id: uuid.v4(),
        companyName: companyNameTextEditingController.text,
        nationalCodeCompany: nationalCodeCompanyTextEditingController.text,
        registrationID: registrationIDTextEditingController.text);
  }

  void save() {
    if (!isLegal.value) {
      saveHaghighiProfile();
    } else {}
    // if (isEdit) {
    //   editUnOfficialItem();
    // } else {
  }

  late SharedPreferences sharedPreferences;

  Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadMyProfileData();
  }

  void loadMyProfileData() {
    String myProfileData = sharedPreferences.getString('pedramm12') ?? '';
    if (myProfileData.isNotEmpty) {
      haghighiViewModel.value =
          HaghighiViewModel.fromJson(jsonDecode(myProfileData));

      firstNameTextEditingController.text = haghighiViewModel.value!.firstName;

      uint8ListSignature(
          base64Decode(haghighiViewModel.value!.signatureUint8List));

      if (uint8ListSignature.value != null) {
        isShowSignature.value = true;
      }

      // uint8ListSealImage(
      //     Uint8List.fromList(haghighiViewModel.value!.sealUint8List.codeUnits));
      // print(uint8ListSealImage);

      // log('${haghighiViewModel.value!.signatureUint8List.codeUnits}');
    }
  }

  void saveMyProfileData() {
    String myProfileData = json.encode(_haghighiDto.toJson());
    sharedPreferences.setString('pedramm12', myProfileData);

    log(myProfileData);
  }

  void saveHaghighiProfile() {
    saveMyProfileData();
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
