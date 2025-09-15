import 'package:flutter/material.dart';

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({super.key});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with TickerProviderStateMixin {
  late AnimationController _topLeftController;
  late AnimationController _topRightController;
  late AnimationController _bottomLeftController;
  late AnimationController _bottomRightController;

  late Animation<double> _topLeftAnimation;
  late Animation<double> _topRightAnimation;
  late Animation<double> _bottomLeftAnimation;
  late Animation<double> _bottomRightAnimation;

  @override
  void initState() {
    super.initState();

    // Top Left Circle (Size 10, Green)
    _topLeftController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _topLeftAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _topLeftController,
      curve: Curves.easeInOut,
    ));

    // Top Right Circle (Size 7, Orange)
    _topRightController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _topRightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _topRightController,
      curve: Curves.easeInOut,
    ));

    // Bottom Left Circle (Size 10, Purple)
    _bottomLeftController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _bottomLeftAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomLeftController,
      curve: Curves.easeInOut,
    ));

    // Bottom Right Circle (Size 12, Blue)
    _bottomRightController = AnimationController(
      duration: const Duration(seconds: 7),
      vsync: this,
    );
    _bottomRightAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bottomRightController,
      curve: Curves.easeInOut,
    ));

    // Start all animations
    _topLeftController.repeat(reverse: true);
    _topRightController.repeat(reverse: true);
    _bottomLeftController.repeat(reverse: true);
    _bottomRightController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _topLeftController.dispose();
    _topRightController.dispose();
    _bottomLeftController.dispose();
    _bottomRightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top Left Circle - Green, Size 10
        Positioned(
          top: 40,
          left: 30,
          child: AnimatedBuilder(
            animation: _topLeftAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _topLeftAnimation.value * 20),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),

        // Top Right Circle - Orange, Size 7
        Positioned(
          top: 20,
          right: 50,
          child: AnimatedBuilder(
            animation: _topRightAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(10, _topRightAnimation.value * 30),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom Left Circle - blue, Size 10
        Positioned(
          bottom: 20,
          left: 60,
          child: AnimatedBuilder(
            animation: _bottomLeftAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(10, -_bottomLeftAnimation.value * 30),
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom Right Circle - purple, Size 12
        Positioned(
          bottom: 20,
          right: 20,
          child: AnimatedBuilder(
            animation: _bottomRightAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -_bottomRightAnimation.value * 20),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.7),
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
