import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  const ScrollToHideWidget(
      {Key? key,
      required this.scrollController,
      required this.child,
      this.duration = const Duration(milliseconds: 300),
      this.height = kBottomNavigationBarHeight})
      : super(key: key);
  final ScrollController scrollController;
  final Widget child;
  final Duration duration;
  final double height;

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(listen);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {});
    super.dispose();
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? widget.height : 0,
      child: Wrap(
        children: [widget.child],
      ),
    );
  }
}
