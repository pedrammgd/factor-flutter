import 'package:hive/hive.dart';

part 'store_item_view_model_hive.g.dart';

@HiveType(typeId: 2)
class StoreItemViewModelHive {
  StoreItemViewModelHive(
      {required this.id,
      required this.productDescription,
      required this.productCount,
      required this.productUnitPrice,
      required this.totalPriceItem,
      required this.unitValue,
      });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String productDescription;
  @HiveField(2)
  final double productCount;
  @HiveField(3)
  final String productUnitPrice;
  @HiveField(4)
  final String unitValue;

  @HiveField(5)
  final double totalPriceItem;
}
