import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:get/get.dart';

class AnimatedTypingText extends StatefulWidget {
  const AnimatedTypingText({
    super.key,
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText> {
  final languageController = Get.find<LanguageController>();
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          languageController.getText(AppStrings.home, 'subtitle'),
          textStyle: AppTextStyles.displayLarge(
              color: const Color(0xFF2196F3), weight: AppTextStyles.semiBold),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          languageController.getText(AppStrings.home, 'subtitle2'),
          textStyle: AppTextStyles.displayLarge(
              color: const Color(0xFF9C27B0), weight: AppTextStyles.semiBold),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          languageController.getText(AppStrings.home, 'subtitle3'),
          textStyle: AppTextStyles.displayLarge(
              color: Colors.orange, weight: AppTextStyles.semiBold),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      repeatForever: true,
      pause: const Duration(milliseconds: 800),
      isRepeatingAnimation: true,
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
    );
  }
}
