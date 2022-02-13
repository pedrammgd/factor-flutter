class PersonBasicInformationViewModel {
  PersonBasicInformationViewModel(
      {required this.id,
      this.address,
      this.mobileNumber,
      this.firstName,
      this.lastName,
      this.nationalCode,
      this.companyName,
      this.nationalCodeCompany,
      this.registrationID,
      this.mobileNumberHoghoghi,
      this.addressHoghoghi,
      required this.isHaghighi});

  final String id;
  final String? address;
  final String? addressHoghoghi;
  final String? mobileNumber;
  final String? mobileNumberHoghoghi;
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
          mobileNumberHoghoghi: json['mobileNumberHoghoghi'],
          addressHoghoghi: json['addressHoghoghi'],
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
        'mobileNumberHoghoghi': mobileNumberHoghoghi,
        'isHaghighi': isHaghighi,
        'addressHoghoghi': addressHoghoghi,
      };
}
