import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatefulWidget {
  const CustomModalBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomModalBottomSheetState createState() => _CustomModalBottomSheetState();
}

class _CustomModalBottomSheetState extends State<CustomModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }


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
}
