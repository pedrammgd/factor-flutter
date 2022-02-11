import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';

class MyProfileViewModel {
  MyProfileViewModel({
    required this.personBasicInformationViewModel,
    required this.sealUint8List,
    required this.logoUint8List,
    required this.signatureUint8List,
  });

  final String sealUint8List;
  final String logoUint8List;
  final String signatureUint8List;
  final PersonBasicInformationViewModel personBasicInformationViewModel;

  factory MyProfileViewModel.fromJson(Map<String, dynamic> json) =>
      MyProfileViewModel(
        personBasicInformationViewModel:
            PersonBasicInformationViewModel.fromJson(
                json['personBasicInformationViewModel']),
        signatureUint8List: json['signatureUint8List'],
        sealUint8List: json['sealUint8List'],
        logoUint8List: json['logoUint8List'],
      );

  Map<String, dynamic> toJson() => {
        'signatureUint8List': signatureUint8List,
        'sealUint8List': sealUint8List,
        'logoUint8List': logoUint8List,
        'personBasicInformationViewModel':
            personBasicInformationViewModel.toJson()
      };
}
