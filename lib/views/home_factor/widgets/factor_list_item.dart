import 'package:factor_flutter_mobile/core/constans/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FactorListItem extends StatelessWidget {
  const FactorListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10, end: 20, start: 20),
      child: Ink(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 20, start: 20),
                      child: Text(
                        'فاکتور فروش محصولات اینترنتی',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )),
                    Constants.largeHorizontalSpacer,
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          size: 20,
                        )),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(start: 20, bottom: 10),
                      child: Text('فاکتور غیر رسمی'),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 10, bottom: 10),
                      child: Text(
                        '1400/01/01',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
