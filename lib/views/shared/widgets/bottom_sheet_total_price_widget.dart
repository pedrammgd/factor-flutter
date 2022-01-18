import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'key_value_text_widget.dart';

class BottomSheetTotalPriceWidget extends StatelessWidget {
  const BottomSheetTotalPriceWidget(
      {required this.price,
      this.discount = '0',
      this.taxation = '0',
      required this.totalPrice,
      required this.totalWordPrice});

  final String price;
  final String discount;
  final String taxation;
  final String totalPrice;
  final String totalWordPrice;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: price,
            keyText: 'قیمت :',
          ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: discount,
            keyText: 'تخفیف :',
          ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: taxation,
            keyText: 'مالیات :',
          ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: totalPrice,
            keyText: 'قیمت کل :',
          ),
              Constants.mediumVerticalSpacer,
              Row(
                children: [
                  Constants.mediumHorizontalSpacer,
                  Expanded(
                child: Text(
                  totalWordPrice,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
                  Constants.mediumHorizontalSpacer,
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 10, top: 15, bottom:20),
                child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () {}, child: Text('ادامه'))),
              ),
              Constants.mediumVerticalSpacer,
            ],
          ),
      //   ),
      // ),
    );
  }
}
