class SpecificationCostViewModel {
  SpecificationCostViewModel({
    required this.id,
    required this.title,
    required this.price,
  });

  final String id;
  final String title;
  final String price;

  factory SpecificationCostViewModel.fromJson(Map<String, dynamic> json) =>
      SpecificationCostViewModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
      };
}
