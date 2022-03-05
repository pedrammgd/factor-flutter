class FactorHomeViewModel {
  FactorHomeViewModel({
    required this.id,
    required this.uint8ListPdf,
    required this.titleFactor,
    required this.dateFactor,
    required this.numFactor,
  });

  final String id;
  final String uint8ListPdf;
  final String titleFactor;
  final String dateFactor;
  final String numFactor;


  factory FactorHomeViewModel.fromJson(Map<String, dynamic> json) =>
      FactorHomeViewModel(
        id: json['id'],
        uint8ListPdf: json['uint8ListPdf'],
        titleFactor: json['titleFactor'],
        dateFactor: json['dateFactor'],
        numFactor: json['numFactor'],

      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uint8ListPdf': uint8ListPdf,
        'dateFactor': dateFactor,
        'titleFactor': titleFactor,
        'numFactor': numFactor,

      };
}
