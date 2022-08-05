import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FactorTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validatorTextField;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLines;
  final TextInputAction? textInputAction;

  final double paddingTop;
  final double paddingBottom;
  final double paddingStart;
  final double paddingEnd;

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
  final Color? fillColor;
  final bool hasBorder;
  final bool? alignLabelWithHint;
  final TextAlignVertical? textAlignVertical;
  final Color? borderColor;
  final double borderRadius;
  final String? hintText;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? suffixText;
  final Color? suffixColor;
  final Color? labelColor;
  final bool? enabled;
  final Function(String)? onFieldSubmitted;
  final bool autofocus;
  final Function()? onPressedClearButton;

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
    this.maxLength,
    this.onTap,
    this.hasPrefixIcon = true,
    this.showCursor = true,
    this.readOnly = false,
    this.onChanged,
    this.focusNode,
    this.fillColor,
    this.hasBorder = false,
    this.alignLabelWithHint,
    this.textAlignVertical,
    this.height,
    this.borderColor,
    this.suffixIcon,
    this.borderRadius = 10,
    this.hintText,
    this.floatingLabelBehavior,
    this.suffixText,
    this.suffixColor,
    this.labelColor,
    this.paddingTop = 5,
    this.paddingBottom = 5,
    this.paddingStart = 0,
    this.paddingEnd = 0,
    this.onFieldSubmitted,
    this.enabled,
    this.autofocus = true,
    this.onPressedClearButton,
  });

  @override
  State<FactorTextFormField> createState() => _FactorTextFormFieldState();
}

class _FactorTextFormFieldState extends State<FactorTextFormField> {
  FocusNode focusNodeInner = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: widget.paddingTop,
          start: widget.paddingStart,
          end: widget.paddingEnd,
          bottom: widget.paddingBottom),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextFormField(
            autofocus: autofocusFactor(),
            enabled: widget.enabled,
            onFieldSubmitted: onFieldSubmitted(),
            onTap: widget.onTap,
            textAlignVertical: widget.textAlignVertical,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.end,
            focusNode: widget.focusNode ?? focusNodeInner,
            onChanged: (text) {
              if (widget.onChanged != null) {
                widget.onChanged!(text);
              }
              setState(() {});
            },
            controller: widget.controller,
            validator: widget.validatorTextField,
            keyboardType: widget.textInputType,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            showCursor: widget.showCursor,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
                hintText: widget.hintText,
                floatingLabelBehavior: widget.floatingLabelBehavior,
                hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary),
                hintTextDirection: TextDirection.ltr,
                // suffixIconConstraints: const BoxConstraints(
                //     // minHeight: 24,
                //     // minWidth: 24,
                //     maxWidth: 100,
                //     maxHeight: 50),
                alignLabelWithHint: widget.alignLabelWithHint,
                contentPadding: EdgeInsets.all(widget.contentPadding),
                filled: true,
                suffixIcon:
                    // widget.controller!.text.isNotEmpty
                    //     ? IconButton(
                    //         onPressed: () {
                    //           setState(() {
                    //             widget.controller?.clear();
                    //           });
                    //         },
                    //         icon: const Icon(Icons.clear))
                    //     : widget.suffixIcon,

                    _suffixIconWidget(
                  focusNode: widget.focusNode ?? focusNodeInner,
                  controller: widget.controller,
                  // suffixIcon: widget.suffixIcon
                ),
                suffixText: widget.suffixText,
                suffixStyle: TextStyle(
                    fontSize: 12,
                    fontFamily: 'IRANSans',
                    color: widget.suffixColor ??
                        Theme.of(context).colorScheme.secondary),
                fillColor: widget.fillColor ?? Theme.of(context).primaryColor,
                prefixIcon: widget.hasPrefixIcon
                    ? widget.prefixIcon
                    : const SizedBox.shrink(),
                prefixIconConstraints: BoxConstraints(
                    minWidth: widget.hasPrefixIcon ? 45 : 20,
                    minHeight: widget.hasPrefixIcon ? 45 : 0),
                labelText: widget.labelText,
                labelStyle: TextStyle(
                    fontSize: 15,
                    color: widget.labelColor ??
                        Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.6)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5,
                    color: widget.hasBorder
                        ? widget.borderColor ??
                            Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: widget.hasBorder
                        ? widget.borderColor ??
                            Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                  ),
                ))),
      ),
    );
  }

  void Function(String)? onFieldSubmitted() {
    if (widget.controller != null) {
      if (widget.suffixIcon != null) {
        return (_) {
          if (widget.controller!.text.isNotEmpty) {
            FocusScope.of(context).nextFocus();
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        };
      } else if (widget.controller!.text.isNotEmpty) {
        return (_) {
          FocusScope.of(context).nextFocus();
        };
      } else {
        return widget.onFieldSubmitted;
      }
    } else {
      return widget.onFieldSubmitted;
    }
  }

  bool autofocusFactor() {
    if (widget.autofocus == false || widget.controller == null) {
      return false;
    } else if (widget.controller!.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget _suffixIconWidget(
      {FocusNode? focusNode, TextEditingController? controller}) {
    if (controller == null) {
      return const SizedBox();
    } else if (controller.text.isEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 14.0),
        child: widget.suffixIcon ?? const SizedBox(),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget.suffixIcon ?? const SizedBox(),
          IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
              onPressed: () {
                controller.clear();
                if (focusNode != null) {
                  focusNode.requestFocus();
                }
                if (widget.onPressedClearButton != null) {
                  widget.onPressedClearButton!();
                }
                setState(() {});
              }),
        ],
      );
    }
  }
}

// class _SuffixIconWidget extends StatefulWidget {
//   const _SuffixIconWidget(
//       {Key? key, this.textEditingController, this.suffixIcon, this.focusNode})
//       : super(key: key);
//
//   final TextEditingController? textEditingController;
//   final Widget? suffixIcon;
//   final FocusNode? focusNode;
//
//   @override
//   State<_SuffixIconWidget> createState() => _SuffixIconWidgetState();
// }
//
// class _SuffixIconWidgetState extends State<_SuffixIconWidget> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.textEditingController == null) {
//       return const SizedBox();
//     } else if (widget.textEditingController!.text.isEmpty) {
//       return Padding(
//         padding: const EdgeInsetsDirectional.only(end: 14.0),
//         child: widget.suffixIcon ?? const SizedBox(),
//       );
//     } else {
//       return Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           widget.suffixIcon ?? const SizedBox(),
//           IconButton(
//               icon: const Icon(
//                 Icons.clear,
//                 color: Colors.red,
//               ),
//               onPressed: () {
//                 setState(() {
//                   widget.textEditingController?.clear();
//                   if (widget.focusNode != null) {
//                     widget.focusNode?.requestFocus();
//                   }
//                 });
//               }),
//         ],
//       );
//     }
//   }
// }
