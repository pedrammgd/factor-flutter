import 'dart:math' as math show pi;

import 'package:factor_flutter_mobile/views/shared/widgets/lable/lable_widget.dart';
import 'package:flutter/material.dart';

part 'factor_controller_expandable.dart';

part 'factor_icon_expandable.dart';

typedef OnHeaderTap = Function(bool isExpand);

class FactorExpandable extends StatefulWidget {
  ///animation duration
  final int? milliseconds;

  ///animation
  final Duration _animationDuration;

  /// header widget that appears in top
  final Widget? headerWidget;

  /// a widget that appears when state is not in expand mode
  final Widget? collapsedWidget;

  /// a widget that appears when state is in expand mode
  final Widget expandedWidget;

  /// whether to show header or not
  final bool showHeader;

  /// whether to show a border on default header widget by default or not
  final bool showDefaultHeaderBorder;

  /// when user tapped in header, expand/collapse widget by default or not
  final bool expandOnHeaderTapped;

  /// a widget that appears in the start of default header
  final Widget? defaultHeaderLabel;

  /// a widget that appears in the end of default header
  final Widget? defaultHeaderIcon;

  /// the shape of default header widget
  final BoxDecoration? defaultHeaderDecoration;

  /// color of default header's Icon
  final Color? defaultHeaderIconColor;

  /// a function that calls when user tapped on header
  final OnHeaderTap? onHeaderTap;

  /// to control expand or collapse widget
  final FactorExpandableController? controller;

  /// space between header and body
  final double? headerBodySpace;

  final double splashRadius;

  /// how animate expansion.
  ///
  ///  for more info visit
  /// [Flutter Curves](https://api.flutter.dev/flutter/animation/Curves-class.html)
  final Curve? customCurve;

  ///Size icon Animation
  final double iconSize;

  final double paddingIconStart;
  final double paddingIconEnd;
  final double paddingIconTop;
  final double paddingIconBottom;

  final bool isStackMode;

  FactorExpandable(
      {this.collapsedWidget,
      required this.expandedWidget,
      this.headerWidget,
      this.defaultHeaderLabel,
      this.defaultHeaderIcon,
      this.defaultHeaderDecoration,
      this.showHeader = true,
      this.showDefaultHeaderBorder = true,
      this.expandOnHeaderTapped = true,
      this.defaultHeaderIconColor,
      this.onHeaderTap,
      this.customCurve,
      this.controller,
      this.iconSize = 30,
      this.headerBodySpace = 0,
      this.paddingIconBottom = 0,
      this.paddingIconEnd = 0,
      this.paddingIconStart = 0,
      this.paddingIconTop = 0,
      this.milliseconds = 1000,
      this.splashRadius = 0,
      this.isStackMode = false})
      : assert(headerBodySpace != null && headerBodySpace >= 0),
        _animationDuration = Duration(milliseconds: milliseconds!);

  @override
  _FactorExpandableState createState() => _FactorExpandableState();
}

class _FactorExpandableState extends State<FactorExpandable>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _effectiveController,
      builder: (context, isExpanded, child) =>
          // widget.isStackMode
          //     ? Stack(
          //         children: [
          //           Column(
          //             children: [
          //               SizedBox(height: widget.headerBodySpace),
          //               _getBody,
          //             ],
          //           ),
          //           if (widget.showHeader) _getHeader,
          //         ],
          //       )
          //     :
          Column(
        children: [
          if (widget.showHeader) _getHeader,
          SizedBox(height: widget.headerBodySpace),
          _getBody,
        ],
      ),
    );
  }

  Widget get _getHeader {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey[50],
        borderRadius: BorderRadius.circular(widget.splashRadius),
        onTap: () {
          if (widget.expandOnHeaderTapped) _effectiveController.toggle();
          widget.onHeaderTap?.call(_effectiveController.expanded);
        },
        child: widget.headerWidget ?? _defaultHeader,
      ),
    );
  }

  Widget get _getBody {
    return AnimatedSize(
      duration: widget._animationDuration,
      reverseDuration: widget._animationDuration,
      curve: widget.customCurve ?? Curves.easeOut,
      // vsync: this,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.collapsedWidget != null)
            _effectiveController.expanded
                ? widget.expandedWidget
                : widget.collapsedWidget!,
          if (widget.collapsedWidget == null && _effectiveController.expanded)
            widget.expandedWidget,
        ],
      ),
    );
  }

  Widget get _defaultHeader {
    final Color _color =
        widget.defaultHeaderIconColor ?? Theme.of(context).primaryColor;

    return DecoratedBox(
      decoration: _getHeaderDecoration,
      child: FactorLabeledWidget(
        label: widget.defaultHeaderLabel,
        labelAlignment: AlignmentDirectional.centerStart,
        labelFlex: 1,
        childFlex: 0,
        child: widget.defaultHeaderIcon ?? _defaultHeaderIcon(_color),
      ),
    );
  }

  BoxDecoration get _getHeaderDecoration =>
      widget.defaultHeaderDecoration ??
      BoxDecoration(
          border: widget.showDefaultHeaderBorder
              ? const Border(
                  bottom: BorderSide(width: 0.7, color: Colors.black54))
              : null);

  Widget _defaultHeaderIcon(Color _primaryColor) => Padding(
        padding: EdgeInsetsDirectional.only(
            start: widget.paddingIconStart,
            bottom: widget.paddingIconBottom,
            top: widget.paddingIconTop,
            end: widget.paddingIconEnd),
        child: FactorExpandIcon(
          isExpanded: _effectiveController.expanded,
          color: _primaryColor,
          padding: EdgeInsets.zero,
          duration: widget._animationDuration,
          size: widget.iconSize,
        ),
      );

  final FactorExpandableController _controller =
      FactorExpandableController(false);

  FactorExpandableController get _effectiveController =>
      widget.controller ?? _controller;
}
