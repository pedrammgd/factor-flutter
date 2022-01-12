import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BottomSheetTotalPriceWidget extends StatelessWidget {
  const BottomSheetTotalPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 50.0,
          color: Colors.black,
          offset: Offset(2, 48),
        )
      ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.xLargeVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Constants.mediumHorizontalSpacer,
              Text(
                'قیمت کل :',
                style: TextStyle(fontSize: 20),
              ),
              Constants.mediumHorizontalSpacer,
              Text(
                ' 454,654,645,645 ریال',
                style: TextStyle(fontSize: 20),
              ),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.smallVerticalSpacer,
          Row(
            children: [
              Constants.largeHorizontalSpacer,
              Text(
                'هزارو پانصد هزار تومان',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 10, end: 10, top: 15, bottom: 5),
            child: SizedBox(
                height: 50,
                width: double.infinity,
                child: OutlinedButton(onPressed: () {}, child: Text('ادامه'))),
          )
        ],
      ),
    );
  }
}
