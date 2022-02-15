import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';

class MyProfileViewModel {
  MyProfileViewModel({
    required this.personBasicInformationViewModel,
    this.sealUint8List,
    this.logoUint8List,
    this.signatureUint8List,
    this.sealUint8ListHoghoghi,
    this.logoUint8ListHoghoghi,
    this.signatureUint8ListHoghoghi,
  });

  final String? sealUint8List;
  final String? logoUint8List;
  final String? signatureUint8List;
  final String? sealUint8ListHoghoghi;
  final String? logoUint8ListHoghoghi;
  final String? signatureUint8ListHoghoghi;
  final PersonBasicInformationViewModel personBasicInformationViewModel;

  factory MyProfileViewModel.fromJson(Map<String, dynamic> json) =>
      MyProfileViewModel(
        personBasicInformationViewModel:
            PersonBasicInformationViewModel.fromJson(
                json['personBasicInformationViewModel']),
        signatureUint8List: json['signatureUint8List'],
        sealUint8List: json['sealUint8List'],
        logoUint8List: json['logoUint8List'],
        sealUint8ListHoghoghi: json['sealUint8ListHoghoghi'],
        logoUint8ListHoghoghi: json['logoUint8ListHoghoghi'],
        signatureUint8ListHoghoghi: json['signatureUint8ListHoghoghi'],
      );

  Map<String, dynamic> toJson() => {
        'signatureUint8List': signatureUint8List,
        'sealUint8List': sealUint8List,
        'logoUint8List': logoUint8List,
        'sealUint8ListHoghoghi': sealUint8ListHoghoghi,
        'logoUint8ListHoghoghi': logoUint8ListHoghoghi,
        'signatureUint8ListHoghoghi': signatureUint8ListHoghoghi,
        'personBasicInformationViewModel':
            personBasicInformationViewModel.toJson()
      };
}
