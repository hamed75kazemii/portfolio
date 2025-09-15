import 'package:flutter/foundation.dart'; // برای kIsWeb
import 'package:flutter/material.dart';

class TapHandler extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final bool hasEdge;
  final double borderRadius;
  final bool hasReflex;

  const TapHandler(
      {required this.child,
      required this.onTap,
      super.key,
      this.hasEdge = false,
      this.hasReflex = true,
      this.borderRadius = 25});

  @override
  Widget build(BuildContext context) {
    return hasReflex
        ? InkWell(
            borderRadius: BorderRadius.circular(hasEdge ? 0 : borderRadius),
            onTap: () {
              onTap();
            },
            enableFeedback: hasReflex,
            child: child,
          )
        : InkWell(
            splashColor: Colors.transparent, // Removes the ripple effect
            highlightColor: Colors.transparent, // Removes the highlight effect
            onTap: () {
              onTap();
            },
            enableFeedback: hasReflex,
            child: child,
          );
  }
}
