class FactorUnofficialItemViewModel {
  FactorUnofficialItemViewModel(
      {required this.id,
      required this.productDescription,
      required this.productCount,
      required this.productUnitPrice,
      required this.productDiscount,
      required this.totalPriceItem,
      required this.unitValue,
      required this.productTaxation});

  final String id;
  final String productDescription;
  final int productCount;
  final String productUnitPrice;
  final String unitValue;
  final double productDiscount;
  final double productTaxation;
  final double totalPriceItem;

  factory FactorUnofficialItemViewModel.fromJson(Map<String, dynamic> json) =>
      FactorUnofficialItemViewModel(
        id: json['id'],
        productDescription: json['productDescription'],
        productCount: json['productCount'],
        productUnitPrice: json['productUnitPrice'],
        productDiscount: json['productDiscount'],
        productTaxation: json['productTaxation'],
        totalPriceItem: json['totalPriceItem'],
        unitValue: json['unitValue'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productDescription': productDescription,
        'productCount': productCount,
        'productUnitPrice': productUnitPrice,
        'productDiscount': productDiscount,
        'productTaxation': productTaxation,
        'totalPriceItem': totalPriceItem,
        'unitValue': unitValue,
      };
}
