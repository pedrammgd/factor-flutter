import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class FactorBodyAppBarSliver extends StatelessWidget {
  const FactorBodyAppBarSliver(
      {required this.body, required this.title, required this.bottomWidget});
  final Widget body;
  final Widget title;
  final PreferredSizeWidget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        body: body,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                Wrap(
                  children: [
                    // Constants.mediumVerticalSpacer,
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        top: 15,
                        end: 34,
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.5),
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
                      ),
                    ),
                  ],
                ),
              ],
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: const SizedBox.shrink(),
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
