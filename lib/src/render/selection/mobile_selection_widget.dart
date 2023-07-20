import 'package:flutter/material.dart';

class MobileSelectionWidget extends StatelessWidget {
  const MobileSelectionWidget({
    Key? key,
    required this.layerLink,
    required this.rect,
    required this.selectionColor,
    required this.selectionHandlerColor,
    this.decoration,
    this.showLeftHandler = false,
    this.showRightHandler = false,
  }) : super(key: key);

  final Color selectionColor;
  final Color selectionHandlerColor;
  final Rect rect;
  final LayerLink layerLink;
  final BoxDecoration? decoration;
  final bool showLeftHandler;
  final bool showRightHandler;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: rect,
      child: CompositedTransformFollower(
        link: layerLink,
        offset: rect.topLeft,
        showWhenUnlinked: true,
        // Ignore the gestures in selection overlays
        //  to solve the problem that selection areas cannot overlap.
        child: IgnorePointer(
          child: MobileSelectionWithHandler(
            selectionColor: selectionColor,
            handlerColor: selectionHandlerColor,
            decoration: decoration,
            showLeftHandler: showLeftHandler,
            showRightHandler: showRightHandler,
          ),
        ),
      ),
    );
  }
}

class MobileSelectionWithHandler extends StatelessWidget {
  const MobileSelectionWithHandler({
    super.key,
    required this.selectionColor,
    required this.handlerColor,
    this.showLeftHandler = false,
    this.showRightHandler = false,
    this.decoration,
    this.handlerWidth = 2.0,
  });

  final Color selectionColor;
  final BoxDecoration? decoration;

  final bool showLeftHandler;
  final bool showRightHandler;
  final Color handlerColor;
  final double handlerWidth;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      color: decoration == null ? selectionColor : null,
      decoration: decoration,
    );
    if (showLeftHandler || showRightHandler) {
      child = Row(
        children: [
          if (showLeftHandler)
            Container(
              width: handlerWidth,
              color: handlerColor,
            ),
          Expanded(child: child),
          if (showRightHandler)
            Container(
              width: handlerWidth,
              color: handlerColor,
            ),
        ],
      );
    }
    return child;
  }
}
