import 'package:factor_flutter_mobile/models/sheard/person_basic_information_view_model.dart/person_basic_information_view_model.dart';

class BuyerViewModel {
  BuyerViewModel({
    required this.personBasicInformationViewModel,
  });

  final PersonBasicInformationViewModel personBasicInformationViewModel;
  factory BuyerViewModel.fromJson(Map<String, dynamic> json) => BuyerViewModel(
        personBasicInformationViewModel:
            PersonBasicInformationViewModel.fromJson(
          json['personBasicInformationViewModel'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'personBasicInformationViewModel':
            personBasicInformationViewModel.toJson(),
      };
}
