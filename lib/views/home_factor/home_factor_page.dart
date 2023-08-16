import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/more/more_controller.dart';
import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
import 'package:factor_flutter_mobile/views/home_factor/widgets/factor_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:random_avatar/random_avatar.dart';

class HomeFactorPage extends GetView<HomeFactorController> {
  const HomeFactorPage();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeFactorController());
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Constants.largeVerticalSpacer,
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _avatar(),
            ],
          ),
        ),
        Constants.mediumVerticalSpacer,
        const FactorList(),
      ],
    );
  }

  Widget _avatar() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 18),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                radius: 32,
                onTap: () {
                  controller.avatar.value = RandomAvatarString(
                    DateTime.now().toIso8601String(),
                  );
                  // getStorage.write(Keys.avatarKey, avatar);
                },
                child: CircleAvatar(
                  radius: 32,
                  child: controller.avatar.value != null
                      ? SvgPicture.string(controller.avatar.value!)
                      : RandomAvatar('saytoonz', height: 65, width: 65),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'فاکتور های من',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).colorScheme.secondary),
            ),
          ],
        ),
      );
    });
  }
}
