import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_card_home_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class FactorListItem extends GetView<HomeFactorController> {
  const FactorListItem({required this.factorItem});

  final FactorViewModel factorItem;

  @override
  Widget build(BuildContext context) {
    return FactorCardHomeWidget(
      title: factorItem.title,
      removeOnTap: () {
        controller.factorList.remove(factorItem);
      },
    );
  }
}
