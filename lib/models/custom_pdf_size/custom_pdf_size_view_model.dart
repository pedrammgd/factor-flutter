class CustomPdfSizeViewModel {
  CustomPdfSizeViewModel({
    required this.pdfFormat,
  });

  final int pdfFormat;

  factory CustomPdfSizeViewModel.fromJson(Map<String, dynamic> json) =>
      CustomPdfSizeViewModel(
        pdfFormat: json['pdfFormat'],
      );

  Map<String, dynamic> toJson() => {
        'pdfFormat': pdfFormat,
      };
}
