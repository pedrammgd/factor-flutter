import 'dart:typed_data';

import 'package:factor_flutter_mobile/views/shared/widgets/image_picker/camera_gallery_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class MyProfileController extends GetxController {
  RxBool isLegal = false.obs;
  RxInt loopLegal = 1.obs;
  RxBool isShowSignature = false.obs;
  RxBool isShowImage = false.obs;
  Rxn<Uint8List> uint8ListSignature = Rxn<Uint8List>();
  Rxn<Uint8List> uint8ListImage = Rxn<Uint8List>();

  void sealOnTap() {
    CameraOrGalleryBottomSheet.chooseCameraOrGallery(
      Get.context!,
      cameraButtonFunction: () {
        _getImage(imageSource: ImageSource.camera);

        Get.back();
      },
      galleryButtonFunction: () {
        _getImage(imageSource: ImageSource.gallery);

        Get.back();
      },
    );
  }

  Future _getImage({required ImageSource imageSource}) async {
    try {
      var imagePick = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 80,
      );

      if (imagePick != null) {
        XFile imageFile = XFile(imagePick.path);

        Uint8List imageRaw = await imageFile.readAsBytes();
        uint8ListImage.value = imageRaw;
        if (lookupMimeType(imageFile.path, headerBytes: imageRaw)!
            .contains('image')) {
          isShowImage.value = true;
        } else {
          isShowImage.value = false;

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

      return uint8ListImage;
    } catch (e) {
      Get.snackbar(
        'خطا در عکس مهر',
        'مشکلی پیش اومده دوباره تلاش کن',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
