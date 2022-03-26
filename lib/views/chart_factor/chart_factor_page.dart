import 'package:factor_flutter_mobile/controllers/chart_factor/chart_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/views/shared/widgets/factor_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartFactorPage extends GetView<ChartFactorController> {
  ChartFactorPage({Key? key}) : super(key: key);

  final homeController = Get.find<HomeFactorController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ChartFactorController>(() => ChartFactorController());
    return Scaffold(
      appBar: FactorAppBar(
          title: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text('نمودار پرداختی ها',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      )),
      body: Obx(() {
        return Center(
            child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(enable: true, header: ''),
                primaryXAxis: CategoryAxis(
                  autoScrollingDelta: 4,
                ),
                primaryYAxis: NumericAxis(
                    title: AxisTitle(text: controller.currencyTitle().value)),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                series: <LineSeries<FactorHomeViewModel, String>>[
              LineSeries<FactorHomeViewModel, String>(
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataSource: homeController.factorHomeList,
                  xValueMapper: (FactorHomeViewModel factorHome, _) =>
                      factorHome.dateFactor,
                  yValueMapper: (FactorHomeViewModel factorHome, _) =>
                      factorHome.totalPrice)
            ]));
      }),
    );
  }
}
