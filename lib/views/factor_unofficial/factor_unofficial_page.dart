import 'package:factor_flutter_mobile/controllers/factor_unofficial/factor_unofficial_controller.dart';
import 'package:factor_flutter_mobile/views/factor_unofficial/widgets/factor_unofficial_list.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FactorUnofficialPage extends GetView<FactorUnofficialController> {
  const FactorUnofficialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FactorUnofficialController());
    return Scaffold(
      appBar: const FactorAppBar(
        height: 56,
        title: Padding(
          padding: EdgeInsets.only(top: 19.0),
          child: Text(
            'فاکتور جدید',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      body: const FactorUnofficialList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius:  BorderRadius.vertical(top: Radius.circular(30,),),
            ),
            builder: (BuildContext context) {
              return Container(
                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(30))),

                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.all(10),

                            height: 3,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                      FactorTextFormField(
                        width: double.infinity,
                        labelText: 'شرح کالا *',
                        borderColor: Colors.black,
                        hasBorder: true,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: FactorTextFormField(
                            labelText: 'تعداد *',
                          )),
                          Expanded(
                              child: FactorTextFormField(
                            labelText: 'قیمت واحد *',
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FactorTextFormField(
                            labelText: 'تخفیف',
                          )),
                          Expanded(
                              child: FactorTextFormField(
                            labelText: 'مالیات',
                          )),
                        ],
                      ),

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('ثبت'))),
                           ),


                    ],
                  ),

              );
            },
          );

          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   backgroundColor: Colors.transparent,
          //   context: context,
          //   builder: (context) =>
          //       Padding(
          //     padding: MediaQuery.of(context).viewInsets,
          //     child:
          //     GestureDetector(
          //       behavior: HitTestBehavior.opaque,
          //       onTap: () => Get.back(),
          //       child:  DraggableScrollableSheet(
          //             initialChildSize: .5,
          //             maxChildSize: .55,
          //             minChildSize: .35,
          //             builder: (BuildContext context,
          //                     ScrollController scrollController) =>
          //                 Container(
          //                   decoration: BoxDecoration(
          //                   color: Colors.white,
          //                     borderRadius: BorderRadius.vertical(top: Radius.circular(20))
          //                   ),child:
          //                   ListView(
          //                       controller: scrollController,
          //                       children: [
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             Container(
          //                               margin: const EdgeInsetsDirectional.all(10),
          //                               height: 3,
          //                               width: 50,
          //                               decoration: BoxDecoration(
          //                                 color: Colors.black,
          //                                 borderRadius: BorderRadius.circular(20)
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         FactorTextFormField(labelText: 'شرح کالا *',borderColor: Colors.black,hasBorder: true,),
          //                         Row(
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                              Expanded(child: FactorTextFormField(labelText: 'تعداد *',)),
          //
          //                                 Expanded(child: FactorTextFormField(labelText: 'قیمت واحد *',)),
          //                           ],
          //                         ),
          //                         Row(
          //
          //                           children: [
          //                             Expanded(child: FactorTextFormField(labelText: 'تخفیف',)),
          //                             Expanded(child: FactorTextFormField(labelText: 'مالیات',)),
          //                           ],
          //                         ),
          //                           Padding(
          //                             padding: const EdgeInsetsDirectional.only(end: 10,start: 10,top: 20,bottom: 20),
          //                             child: SizedBox(
          //                                 height: 50,
          //                                 child: OutlinedButton(onPressed: (){Get.back();}, child: Text('ثبت'))),
          //                           ),
          //                         ],
          //
          //                     ),
          //                   ),
          //                 ),
          //       )),
          //
          //
          // );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
