import 'package:factor_flutter_mobile/models/sheard/my_profile_view_model/my_profile_view_model.dart';

class HaghighiViewModel extends MyProfileViewModel {
  HaghighiViewModel({
    required String address,
    required String mobileNumber,
    required String logoUint8List,
    required String sealUint8List,
    required String signatureUint8List,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nationalCode,
  }) : super(
            address: address,
            mobileNumber: mobileNumber,
            logoUint8List: logoUint8List,
            sealUint8List: sealUint8List,
            signatureUint8List: signatureUint8List);

  final String id;
  final String firstName;
  final String lastName;
  final String nationalCode;

  factory HaghighiViewModel.fromJson(Map<String, dynamic> json) =>
      HaghighiViewModel(
          id: json['id'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          nationalCode: json['nationalCode'],
          address: json['address'],
          mobileNumber: json['mobileNumber'],
          signatureUint8List: json['signatureUint8List'],
          sealUint8List: json['sealUint8List'],
          logoUint8List: json['logoUint8List']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'nationalCode': nationalCode,
        'address': address,
        'mobileNumber': mobileNumber,
        'signatureUint8List': signatureUint8List,
        'sealUint8List': sealUint8List,
        'logoUint8List': logoUint8List,
      };
}
