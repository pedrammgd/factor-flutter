class FactorViewModel {
  FactorViewModel({required this.id, required this.title});

  final int id;
  final String title;

  factory FactorViewModel.fromJson(Map<String, dynamic> json) =>
      FactorViewModel(
        id: json['id'],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
