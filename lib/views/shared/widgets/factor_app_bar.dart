import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasSearchBar;
  final bool hasBarcodeButton;

  final double height;
  final Widget? title;
  final Widget customWidget;
  final VoidCallback? customBackButtonFunction;
  final Function(String)? onChangedSearchBar;
  final bool? centerTitle;
  final Widget? leadingWidget;
  final TextEditingController? textEditingController;
  final Function()? onPressedClearButton;

  const FactorAppBar({
    this.hasSearchBar = false,
    this.hasBarcodeButton = false,
    this.height = 70,
    this.title,
    this.customWidget = const SizedBox.shrink(),
    this.customBackButtonFunction,
    this.onChangedSearchBar,
    this.centerTitle = true,
    this.leadingWidget,
    this.textEditingController,
    this.onPressedClearButton,
  });

  const factory FactorAppBar.silver({
    required Widget title,
    required Widget body,
    required PreferredSizeWidget bottomWidget,
    ScrollController? controller,
    VoidCallback? customBackButtonFunction,
  }) = _FactorBodyAppBarSliver;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        centerTitle: centerTitle,
        leadingWidth: 53,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(top: 12.0, start: 8),
          child: leadingWidget ??
              BackButtonAppBar(
                  customBackButtonFunction: customBackButtonFunction),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: title ?? const SizedBox.shrink(),
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
                    // if (hasBackButton) Constants.largeHorizontalSpacer,
                  ]),
            ),
          ],
        )));
  }

  Widget _barcodeFactorButton(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      splashColor: Colors.red.shade100,
      onTap: () {
        // FocusManager.instance.primaryFocus?.unfocus();
        Get.defaultDialog(
            title: 'بارکد خوان',
            middleText: 'برای استفاده از بارکد خوان در نسخه جدید منتظر باشید',
            textCancel: 'باشه (:');
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
        autofocus: false,
        controller: textEditingController,
        width: double.infinity,
        onPressedClearButton: onPressedClearButton,
        prefixIcon: const Icon(Icons.search),
        hintText: '.....جستجو کن',
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

class _FactorBodyAppBarSliver extends FactorAppBar {
  const _FactorBodyAppBarSliver({
    required this.body,
    required Widget? title,
    required this.bottomWidget,
    this.controller,
    VoidCallback? customBackButtonFunction,
  }) : super(
          customBackButtonFunction: customBackButtonFunction,
          title: title,
        );

  final Widget body;
  final PreferredSizeWidget bottomWidget;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: controller,
        floatHeaderSlivers: true,
        body: body,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: Wrap(
                children: [
                  // Constants.mediumVerticalSpacer,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      top: 4,
                      start: 10,
                    ),
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: BackButtonAppBar(
                          customBackButtonFunction: customBackButtonFunction),
                    ),
                  ),
                ],
              ),
              floating: true,
              pinned: true,
              centerTitle: true,
              title: title,
              bottom: bottomWidget,
            )
          ];
        });
  }
}

class BackButtonAppBar extends StatelessWidget {
  const BackButtonAppBar({Key? key, this.customBackButtonFunction})
      : super(key: key);
  final VoidCallback? customBackButtonFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(top: 8, start: 8),
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.secondary, width: .1),
          borderRadius: BorderRadius.circular(9)),
      child: InkWell(
        onTap: customBackButtonFunction ?? () => Get.back(),
        borderRadius: BorderRadius.circular(9),
        child: Center(
            child: Icon(
          Icons.arrow_forward,
          size: 22,
          textDirection: TextDirection.ltr,
          color: Theme.of(context).colorScheme.secondary,
        )),
      ),
    );
  }
}
