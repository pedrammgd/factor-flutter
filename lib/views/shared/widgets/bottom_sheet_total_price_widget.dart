import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_border_button.dart';
import 'package:flutter/material.dart';

import 'key_value_text_widget.dart';

class BottomSheetTotalPriceWidget extends StatelessWidget {
  const BottomSheetTotalPriceWidget(
      {this.discount = '0',
      this.taxation = '0',
      required this.totalPrice,
      required this.totalWordPrice,
      this.onTap,
      this.bottomButtonOnTap,
      this.statusBracketKeyText = 0});

  final String discount;
  final String taxation;
  final String totalPrice;
  final String totalWordPrice;
  final Function()? onTap;
  final VoidCallback? bottomButtonOnTap;
  final int statusBracketKeyText;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 1.5,
      elevation: 8,
      shape: const CircularNotchedRectangle(),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.mediumVerticalSpacer,
            // KeyValueTextWidget(
            //   valueText: price,
            //   keyText: 'قیمت :',
            // ),
            KeyValueTextWidget(
              keyTextSize: 18,
              valueTextSize: 18,
              valueText: totalPrice,
              bracketKeyText: _statusBracket(),
              keyText: 'قیمت کل :',
            ),

            Constants.smallVerticalSpacer,
            KeyValueTextWidget(
              keyTextSize: 16,
              valueTextSize: 16,
              valueText: discount,
              keyText: 'تخفیف :',
            ),
            Constants.smallVerticalSpacer,
            KeyValueTextWidget(
              keyTextSize: 16,
              valueTextSize: 16,
              valueText: taxation,
              keyText: 'مالیات :',
            ),
            Constants.smallVerticalSpacer,
            Row(
              children: [
                Constants.mediumHorizontalSpacer,
                Expanded(
                  child: Text(
                    totalWordPrice,
                    style: const TextStyle(
                        fontSize: 15, height: 1.5, fontWeight: FontWeight.bold),
                  ),
                ),
                Constants.mediumHorizontalSpacer,
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 10, top: 15, bottom: 20),
              child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomBorderButton(
                      onPressed: bottomButtonOnTap, titleButton: 'ادامه')),
            ),
            Constants.mediumVerticalSpacer,
          ],
        ),
      ),
    );
  }

  String _statusBracket() {
    if (statusBracketKeyText == 0) {
      return '(تسویه نشده)';
    } else if (statusBracketKeyText == 1) {
      return '(بستانکار)';
    } else {
      return '(تسویه شده)';
    }
  }
}
