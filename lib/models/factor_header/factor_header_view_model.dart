class FactorHeaderViewModel {
  FactorHeaderViewModel({
    required this.title,
    required this.factorNum,
    required this.factorDate,
    required this.isBeforeFactor,
    this.durationBeforeFactor,
  });

  final String title;
   String factorNum;
  final String factorDate;
  final bool isBeforeFactor;
  final String? durationBeforeFactor;

  factory FactorHeaderViewModel.fromJson(Map<String, dynamic> json) =>
      FactorHeaderViewModel(
        title: json['title'],
        factorNum: json['factorNum'],
        factorDate: json['factorDate'],
        isBeforeFactor: json['isBeforeFactor'],
        durationBeforeFactor: json['durationBeforeFactor'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'factorNum': factorNum,
        'factorDate': factorDate,
        'isBeforeFactor': isBeforeFactor,
        'durationBeforeFactor': durationBeforeFactor,
      };
}
