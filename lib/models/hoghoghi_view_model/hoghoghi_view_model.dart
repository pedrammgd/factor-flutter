
import 'package:factor_flutter_mobile/models/sheard/my_profile_view_model/my_profile_view_model.dart';

class HoghoghiViewModel extends MyProfileViewModel {
  HoghoghiViewModel({
    required String address,
    required String mobileNumber,
    required String logoUint8List,
    required String sealUint8List,
    required String signatureUint8List,
    required this.id,
    required this.companyName,
    required this.nationalCodeCompany,
    required this.registrationID,
  }) : super(
            address: address,
            mobileNumber: mobileNumber,
            logoUint8List: logoUint8List,
            sealUint8List: sealUint8List,
            signatureUint8List: signatureUint8List);

  final String id;
  final String companyName;
  final String nationalCodeCompany;
  final String registrationID;

  factory HoghoghiViewModel.fromJson(Map<String, dynamic> json) =>
      HoghoghiViewModel(
          id: json['id'],
          companyName: json['companyName'],
          nationalCodeCompany: json['nationalCodeCompany'],
          registrationID: json['registrationID'],
          address: json['address'],
          mobileNumber: json['mobileNumber'],
          signatureUint8List: json['signatureUint8List'],
          sealUint8List: json['sealUint8List'],
          logoUint8List: json['logoUint8List']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyName': companyName,
        'nationalCodeCompany': nationalCodeCompany,
        'registrationID': registrationID,
        'address': address,
        'mobileNumber': mobileNumber,
        'signatureUint8List': signatureUint8List,
        'sealUint8List': sealUint8List,
        'logoUint8List': logoUint8List,
      };
}
