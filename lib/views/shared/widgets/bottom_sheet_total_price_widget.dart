import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'key_value_text_widget.dart';

class BottomSheetTotalPriceWidget extends StatelessWidget {
  const BottomSheetTotalPriceWidget(
      {required this.price,
      this.discount = 0,
      this.taxation = 0,
      required this.totalPrice});

  final int price;
  final double discount;
  final double taxation;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return
      // Transform.translate(
      // offset: Offset(0.0, -10),
      // child: Container(
      //
      //   decoration:  BoxDecoration(
      //       borderRadius: BorderRadius.circular(15),
      //       color: Colors.white, boxShadow: const [
      //     BoxShadow(
      //       blurRadius: 20.0,
      //       color: Colors.black26,
      //       offset: Offset(2, 1),
      //     )
      //   ]),
      //   child:
        BottomAppBar(
          elevation: 8,
          shape: const CircularNotchedRectangle(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: '$price ریال ',
                keyText: 'قیمت :',
              ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: '$discount ریال ',
                keyText: 'تخفیف :',
              ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: '$taxation ریال ',
                keyText: 'مالیات :',
              ),
              Constants.smallVerticalSpacer,
              KeyValueTextWidget(
                valueText: '$totalPrice ریال ',
                keyText: 'قیمت کل :',
              ),
              Constants.mediumVerticalSpacer,
              Row(
                children: [
                  Constants.mediumHorizontalSpacer,
                  const Expanded(
                    child: Text(
                      'نهصدو نود و نه میلیامئمئممرد و یبربنتدنبدتک میلیون و هزارو پانصد هزار تومان  ',
                      style: TextStyle(fontSize: 14, height: 1.5),
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
