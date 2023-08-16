import 'package:factor_flutter_mobile/controllers/chart_factor/chart_factor_controller.dart';
import 'package:factor_flutter_mobile/controllers/home_factor/home_factor_controller.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/factor_view_model.dart';
import 'package:factor_flutter_mobile/models/factor_view_model/hive/factor_view_model_hive.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: SfCartesianChart(
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  header: '',
                ),
                primaryXAxis: CategoryAxis(
                  autoScrollingDelta: 4,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'مبلغ'),
                ),
                zoomPanBehavior: ZoomPanBehavior(),
                series: <LineSeries<FactorHomeViewModelHive, String>>[
              LineSeries<FactorHomeViewModelHive, String>(
                  color: Theme.of(context).colorScheme.secondary,
                  markerSettings: const MarkerSettings(isVisible: true),
                  enableTooltip: true,
                  dataSource: homeController.boxFactorHome.value as dynamic,
                  xValueMapper: (FactorHomeViewModelHive factorHome, _) =>
                      '${factorHome.dateFactor}  ${factorHome.currencyType ?? ''}',
                  yValueMapper: (FactorHomeViewModelHive factorHome, _) =>
                      factorHome.totalPrice)
            ])),
      ),
    );
  }
}
