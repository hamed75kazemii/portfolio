import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getScreenEdgePadding(context), vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Main footer content
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Copyright text
              Text(
                languageController.getText(AppStrings.footer, 'copyright'),
                textAlign: TextAlign.center,
                maxLines: 2,
                style: isDesktop
                    ? AppTextStyles.bodyMedium(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      )
                    : AppTextStyles.bodySmall(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
              ),

              // Scroll to top button
              //   _buildScrollToTopButton(context),
            ],
          ),
        ],
      ),
    );
  }
}
