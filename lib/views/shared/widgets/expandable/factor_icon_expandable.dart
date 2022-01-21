part of 'factor_expandable.dart';

class FactorExpandIcon extends StatefulWidget {
  const FactorExpandIcon({
    this.isExpanded = false,
    this.size = 24.0,
    this.padding = const EdgeInsets.all(2.0),
    this.color,
    this.duration,
    this.expandedColor,
  }) : assert(padding != null);

  final bool isExpanded;

  final double size;

  final EdgeInsetsGeometry padding;

  final Color? color;

  final Color? expandedColor;

  final Duration? duration;

  @override
  _ExpandIconState createState() => _ExpandIconState();
}

class _ExpandIconState extends State<FactorExpandIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  static final Animatable<double> _iconTurnTween =
      Tween<double>(begin: 0.0, end: 0.5)
          .chain(CurveTween(curve: Curves.fastOutSlowIn));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: widget.duration ?? const Duration(milliseconds: 200),
        vsync: this);
    _iconTurns = _controller.drive(_iconTurnTween);
    if (widget.isExpanded) {
      _controller.value = math.pi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(FactorExpandIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  Color? get _iconColor {
    if (widget.isExpanded && widget.expandedColor != null) {
      return widget.expandedColor;
    }

    if (widget.color != null) {
      return widget.color;
    }
    return Colors.black54;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: RotationTransition(
        turns: _iconTurns,
        child: Icon(
          Icons.expand_more,
          color: _iconColor,
          size: widget.size,
        ),
      ),
    );
  }
}
