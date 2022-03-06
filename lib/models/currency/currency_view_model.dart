class CurrencyViewModel {
  CurrencyViewModel({
    required this.currencyFormat,
  });

  final int currencyFormat;

  factory CurrencyViewModel.fromJson(Map<String, dynamic> json) =>
      CurrencyViewModel(
        currencyFormat: json['currencyFormat'],
      );

  Map<String, dynamic> toJson() => {
        'currencyFormat': currencyFormat,
      };
}
