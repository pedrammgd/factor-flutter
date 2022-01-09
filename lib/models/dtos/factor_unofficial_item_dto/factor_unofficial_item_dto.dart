class FactorUnofficialItemDto {
  FactorUnofficialItemDto(
      {
      required this.productDescription,
      required this.productCount,
      required this.productUnitPrice,
      required this.productDiscount,
      required this.productTaxation});


  final String productDescription;
  final int productCount;
  final int productUnitPrice;
  final int productDiscount;
  final int productTaxation;

  Map<String, dynamic> toJson() => {
        'productDescription': productDescription,
        'productCount': productCount,
        'productUnitPrice': productUnitPrice,
        'productDiscount': productDiscount,
        'productTaxation': productTaxation,
      };
}
