import 'package:flutter/material.dart';

class AnimatedCirclesWidget extends StatefulWidget {
  const AnimatedCirclesWidget({super.key});

  @override
  State<AnimatedCirclesWidget> createState() => _AnimatedCirclesWidgetState();
}

class _AnimatedCirclesWidgetState extends State<AnimatedCirclesWidget>
    with TickerProviderStateMixin {
  late AnimationController _bigCircleController;
  late AnimationController _smallCircleController;
  late Animation<double> _bigCircleOpacityAnimation;
  late Animation<double> _smallCircleOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _bigCircleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _smallCircleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bigCircleOpacityAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _bigCircleController, curve: Curves.easeInOut),
    );

    _smallCircleOpacityAnimation = Tween<double>(begin: 0.5, end: 0.0).animate(
      CurvedAnimation(parent: _smallCircleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bigCircleController.dispose();
    _smallCircleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Purple animated circle (center)
        Center(
          child: AnimatedBuilder(
            animation: _bigCircleOpacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _bigCircleOpacityAnimation.value,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
        // Blue animated circle (bottom left)
        Positioned(
          left: 24,
          bottom: 24,
          child: AnimatedBuilder(
            animation: _smallCircleOpacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _smallCircleOpacityAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
        // Blue animated circle (top right)
        Positioned(
          right: 24,
          top: 24,
          child: AnimatedBuilder(
            animation: _smallCircleOpacityAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _smallCircleOpacityAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
