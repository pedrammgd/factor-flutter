import 'package:hive/hive.dart';

part 'factor_view_model_hive.g.dart';

@HiveType(typeId: 1)
class FactorHomeViewModelHive {
  FactorHomeViewModelHive({
    required this.id,
    required this.uint8ListPdf,
    required this.titleFactor,
    required this.dateFactor,
    required this.numFactor,
    required this.totalPrice,
    this.currencyType,
  });

  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? uint8ListPdf;
  @HiveField(2)
  final String? titleFactor;
  @HiveField(3)
  final String? dateFactor;
  @HiveField(4)
  final String? numFactor;
  @HiveField(5)
  final String? currencyType;
  @HiveField(6)
  final double? totalPrice;
}
