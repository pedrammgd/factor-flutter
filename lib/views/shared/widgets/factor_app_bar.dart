import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasSearchBar;
  final bool hasBarcodeButton;
  final bool hasTitle;
  final bool hasBackButton;
  final double height;
  final Widget title;
  final Widget customWidget;
  final Function()? customBackButtonFunction;
  final Function(String)? onChangedSearchBar;

  const FactorAppBar({
    this.hasSearchBar = false,
    this.hasBarcodeButton = false,
    this.hasBackButton = true,
    this.height = 70,
    this.title = const SizedBox.shrink(),
    this.customWidget = const SizedBox.shrink(),
    this.hasTitle = true,
    this.customBackButtonFunction,
    this.onChangedSearchBar,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 2,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(top: 12.0, start: 8),
          child: hasBackButton ? _backButton(context) : const SizedBox.shrink(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: hasTitle ? title : const SizedBox.shrink(),
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
                    if (hasSearchBar) _searchBar(context) else customWidget,
                    Constants.largeHorizontalSpacer,
                    if (hasBarcodeButton) _barcodeFactorButton(context),
                    // if (hasBackButton) _backButton(context),
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
      margin:
          const EdgeInsetsDirectional.only(start: 3, end: 5, top: 2, bottom: 2),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: 1.5),
          borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        onTap: customBackButtonFunction ?? () => Get.back(),
        borderRadius: BorderRadius.circular(9),
        child: Center(
            child: Icon(
          Icons.arrow_forward_ios,
          textDirection: TextDirection.ltr,
          color: Theme.of(context).colorScheme.secondary,
        )),
      ),
    );
  }

  Widget _barcodeFactorButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      splashColor: Colors.red.shade100,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.defaultDialog(
            title: '?????????? ????????',
            middleText: '???????? ?????????????? ???? ?????????? ???????? ???? ???????? ???????? ?????????? ??????????',
            textCancel: '???????? (:');
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).colorScheme.secondary, width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        child: Image.asset(
          barcodeScannerIcon,
          width: 34,
          height: 34,
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
        prefixIcon: const Icon(Icons.search),
        hintText: '.....?????????? ????',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hasBorder: true,
        borderColor: Theme.of(context).colorScheme.secondary,
        paddingBottom: 0,
        paddingTop: 0,
        contentPadding: 0,
        onChanged: onChangedSearchBar,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, height);
}
