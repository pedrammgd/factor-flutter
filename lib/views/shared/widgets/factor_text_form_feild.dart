import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FactorTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validatorTextField;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final double paddingAll;
  final double contentPadding;
  final double width;
  final double? height;
  final int? maxLength;
  final Function()? onTap;
  final bool hasPrefixIcon;
  final bool showCursor;
  final bool readOnly;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Color fillColor;
  final bool hasBorder;
  final bool? alignLabelWithHint;
  final TextAlignVertical? textAlignVertical;
  final Color borderColor;
  final double borderRadius;
  final String? hintText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? suffixText;


  const FactorTextFormField({
    this.controller,
    this.validatorTextField,
    this.prefixIcon = const Icon(Icons.person_outline),
    this.labelText = '',
    this.inputFormatters = const [],
    this.textInputType,
    this.maxLines,
    this.textInputAction,
    this.width = 248,
    this.contentPadding = 20,
    this.paddingAll = 9,
    this.maxLength,
    this.onTap,
    this.hasPrefixIcon = true,
    this.showCursor = true,
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.fillColor = Colors.black12,
    this.hasBorder = false,
    this.alignLabelWithHint,
    this.textAlignVertical, this.height, this.borderColor = Colors.grey, this.suffixIcon, this.borderRadius = 10, this.hintText, this.floatingLabelBehavior, this.suffixText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingAll),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(

            onTap: onTap,
            textAlignVertical:textAlignVertical ,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.end,
            focusNode: focusNode,
            onChanged: onChanged,
            controller: controller,
            validator: validatorTextField,
            keyboardType: textInputType,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            maxLength: maxLength,
            maxLines: maxLines,
            showCursor: showCursor,
            readOnly: readOnly,
            decoration: InputDecoration(
                hintText: hintText,
                floatingLabelBehavior:floatingLabelBehavior ,

                hintStyle: const TextStyle(fontSize: 12,color: Colors.grey),
                hintTextDirection: TextDirection.ltr,
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 24,
                  minWidth: 24,
                ),
                alignLabelWithHint: alignLabelWithHint,
                contentPadding: EdgeInsets.all(contentPadding),
                filled: true,
                suffixIcon: suffixIcon,
                suffixText: suffixText,
                suffixStyle: const TextStyle(color:  Colors.grey),
                fillColor: fillColor,
                prefixIcon:
                hasPrefixIcon ? prefixIcon : const SizedBox.shrink(),
                prefixIconConstraints: BoxConstraints(
                    minWidth: hasPrefixIcon ? 48 : 20,
                    minHeight: hasPrefixIcon ? 48 : 0),
                labelText: labelText,
                labelStyle: const TextStyle(fontSize: 15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: hasBorder ? borderColor : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: hasBorder ? borderColor : Colors.transparent,
                  ),
                ))),
      ),
    );
  }
}
