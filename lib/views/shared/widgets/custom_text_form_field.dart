import 'package:factor_flutter_mobile/views/shared/widgets/factor_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.labelText,
      this.textEditingController,
      this.maxLines,
      this.textInputType,
      this.prefixIcon = const Icon(Icons.person_outline),
      this.inputFormatters,
      this.maxLength,
      this.validatorTextField,
      this.paddingHorizontal = 0})
      : super(key: key);

  final String labelText;
  final TextEditingController? textEditingController;
  final Widget prefixIcon;
  final int? maxLines;
  final TextInputAction textInputAction = TextInputAction.next;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final String? Function(String?)? validatorTextField;
  final double paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: FactorTextFormField(
        hasBorder: true,
        labelColor: Theme.of(context).colorScheme.secondary,
        borderColor: Theme.of(context).colorScheme.secondary,
        controller: textEditingController,
        width: double.infinity,
        labelText: labelText,
        prefixIcon: prefixIcon,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        textInputType: textInputType,
        validatorTextField: validatorTextField,
      ),
    );
  }
}
