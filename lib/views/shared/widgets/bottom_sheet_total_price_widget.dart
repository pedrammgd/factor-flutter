import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BottomSheetTotalPriceWidget extends StatelessWidget {
  const BottomSheetTotalPriceWidget({required this.price});
  final int price ;

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
          Constants.smallVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Constants.mediumHorizontalSpacer,
               const Text(
                  'قیمت :',
                  style: TextStyle(fontSize: 15),
                ),
              Constants.mediumHorizontalSpacer,
              Spacer(),

               Text(
                '$price',
                style: TextStyle(fontSize: 15),
              ),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.smallVerticalSpacer,
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Constants.mediumHorizontalSpacer,
              const Text(
                'تخفیف :',
                style: TextStyle(fontSize: 15),
              ),
              Constants.mediumHorizontalSpacer,
              Spacer(),
              const Text(
                ' 454,654,645,645 ریال',
                style: TextStyle(fontSize: 15),
              ),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.smallVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Constants.mediumHorizontalSpacer,
              const Text(
                'مالیات :',
                style: TextStyle(fontSize: 15),
              ),
              Constants.mediumHorizontalSpacer,
              Spacer(),
              const Text(
                ' 454,654,645,645 ریال',
                style: TextStyle(fontSize: 15),
              ),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.smallVerticalSpacer,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Constants.mediumHorizontalSpacer,
              const Text(
                'قیمت کل :',
                style: TextStyle(fontSize: 18),
              ),
              Constants.mediumHorizontalSpacer,
              Spacer(),
              const Text(
                ' 999,654,645,645 ریال',
                style: TextStyle(fontSize: 18),
              ),
              Constants.largeHorizontalSpacer,
            ],
          ),
          Constants.mediumVerticalSpacer,
          Row(
            children: [
              Constants.mediumHorizontalSpacer,

               Expanded(
                 child: const Text(
                    'نهصدو نود و نه میلیامئمئممرد و یبربنتدنبدتک میلیون و هزارو پانصد هزار تومان  ',
                    style: TextStyle(fontSize: 14),

              ),
               ),

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
    );
  }
}
