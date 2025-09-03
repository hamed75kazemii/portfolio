import 'package:flutter/material.dart';
import 'package:hamed_portfolio/utils/app_colors.dart';
import 'dart:ui'; // Added for ImageFilter

class GlassmorphicAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  final double expandedHeight;
  final double collapsedHeight;

  const GlassmorphicAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
    this.expandedHeight = 200.0,
    this.collapsedHeight = 80.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final scrollProgress = (constraints.maxHeight - collapsedHeight) /
              (expandedHeight - collapsedHeight);

          // Interpolate gradient colors based on scroll progress
          final startColor = Color.lerp(
            AppGradients.primaryGradient[0],
            AppGradients.secondaryGradient[0],
            scrollProgress,
          )!;

          final endColor = Color.lerp(
            AppGradients.primaryGradient[1],
            AppGradients.secondaryGradient[1],
            scrollProgress,
          )!;

          return FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [startColor, endColor],
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // title: AnimatedOpacity(
            //   opacity: scrollProgress < 0.5 ? 0.0 : 1.0,
            //   duration: const Duration(milliseconds: 200),
            //   child: Text(
            //     title,
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          );
        },
      ),
      actions: actions,
    );
  }
}
