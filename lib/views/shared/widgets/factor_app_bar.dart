import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasSearchBar;
  final bool hasAddFactorButton;
  final bool hasBackButton;
  final double height;
  final Widget title;

  const FactorAppBar({
    this.hasSearchBar = false,
    this.hasAddFactorButton = false,
    this.hasBackButton = true,
    this.height = 80,
    this.title = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        leading: const SizedBox.shrink(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: title,
        flexibleSpace: SafeArea(
            child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 15, end: 10, start: 10),
              child: Row(
                  mainAxisAlignment: hasSearchBar
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (hasSearchBar) _searchBar(context),
                    Constants.largeHorizontalSpacer,
                    if (hasAddFactorButton) _barcodeFactorButton(context),
                    if (hasBackButton) _backButton(context),
                    if (hasBackButton) Constants.largeHorizontalSpacer,
                  ]),
            ),
          ],
        )));
  }

  Widget _backButton(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 1.5),
          borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        onTap: () {
          Get.back();
        },
        borderRadius: BorderRadius.circular(9),
        child: Center(
            child: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.secondary,
        )),
      ),
    );
  }

  Widget _barcodeFactorButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      splashColor: Colors.red.shade100,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          barcodeScannerIcon,
          width: 36,
          height: 36,
          fit: BoxFit.contain,
          // color: Theme.of(context).colorScheme.secondary,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Expanded(
      child: FactorTextFormField(
        width: double.infinity,
        prefixIcon: Icon(Icons.search),
        hintText: '.....جستجو کن',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: Colors.white,
        hasBorder: true,
        borderColor: Theme.of(context).colorScheme.secondary,
        paddingAll: 0,
        contentPadding: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, height);
}
