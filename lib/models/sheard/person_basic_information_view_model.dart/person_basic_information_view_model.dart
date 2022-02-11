class PersonBasicInformationViewModel {
  PersonBasicInformationViewModel(
      {required this.id,
      required this.address,
      required this.mobileNumber,
      this.firstName,
      this.lastName,
      this.nationalCode,
      this.companyName,
      this.nationalCodeCompany,
      this.registrationID,
      required this.isHaghighi});

  final String id;
  final String address;
  final String mobileNumber;
  final String? firstName;
  final String? lastName;
  final String? nationalCode;
  final String? companyName;
  final String? nationalCodeCompany;
  final String? registrationID;
  final bool isHaghighi;

  factory PersonBasicInformationViewModel.fromJson(Map<String, dynamic> json) =>
      PersonBasicInformationViewModel(
          id: json['id'],
          firstName: json['firstName'],
          lastName: json['lastName'],
          nationalCode: json['nationalCode'],
          address: json['address'],
          companyName: json['companyName'],
          nationalCodeCompany: json['nationalCodeCompany'],
          registrationID: json['registrationID'],
          mobileNumber: json['mobileNumber'],
          isHaghighi: json['isHaghighi']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'nationalCode': nationalCode,
        'companyName': companyName,
        'nationalCodeCompany': nationalCodeCompany,
        'registrationID': registrationID,
        'address': address,
        'mobileNumber': mobileNumber,
        'isHaghighi': isHaghighi,
      };
}
