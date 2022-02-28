class PersonBasicInformationViewModel {
  PersonBasicInformationViewModel(
      {required this.id,
      this.address,
      this.mobileNumber,
      this.fullName,
      this.nationalCode,
      this.companyName,
      this.nationalCodeCompany,
      this.mobileNumberHoghoghi,
      this.addressHoghoghi,
      required this.isHaghighi});

  final String id;
  final String? address;
  final String? addressHoghoghi;
  final String? mobileNumber;
  final String? mobileNumberHoghoghi;
  final String? fullName;
  final String? nationalCode;
  final String? companyName;
  final String? nationalCodeCompany;
  final bool isHaghighi;

  factory PersonBasicInformationViewModel.fromJson(Map<String, dynamic> json) =>
      PersonBasicInformationViewModel(
          id: json['id'],
          fullName: json['fullName'],
          nationalCode: json['nationalCode'],
          address: json['address'],
          companyName: json['companyName'],
          nationalCodeCompany: json['nationalCodeCompany'],
          mobileNumber: json['mobileNumber'],
          mobileNumberHoghoghi: json['mobileNumberHoghoghi'],
          addressHoghoghi: json['addressHoghoghi'],
          isHaghighi: json['isHaghighi']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'nationalCode': nationalCode,
        'companyName': companyName,
        'nationalCodeCompany': nationalCodeCompany,
        'address': address,
        'mobileNumber': mobileNumber,
        'mobileNumberHoghoghi': mobileNumberHoghoghi,
        'isHaghighi': isHaghighi,
        'addressHoghoghi': addressHoghoghi,
      };
}
