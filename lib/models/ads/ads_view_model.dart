class AdsViewModel {
  AdsViewModel({
    required this.isShowAd,
    required this.imageAd,
    required this.heightAd,
    required this.linkAd,
  });

  final bool isShowAd;
  final String imageAd;
  final String linkAd;
  final int heightAd;

  factory AdsViewModel.fromJson(Map<String, dynamic> json) => AdsViewModel(
        isShowAd: json['isShowAd'],
        imageAd: json['imageAd'],
        heightAd: json['heightAd'],
        linkAd: json['linkAd'],
      );

  Map<String, dynamic> toJson() => {
        'isShowAd': isShowAd,
        'imageAd': imageAd,
        'heightAd': heightAd,
        'linkAd': linkAd,
      };
}
