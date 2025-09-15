import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WorkTogetherSection extends StatelessWidget {
  const WorkTogetherSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final bool isDesktop = MediaQuery.of(context).size.width > 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getScreenEdgePadding(context), vertical: 80),
      child: Column(
        children: [
          // Main heading
          Text(
            languageController.getText(AppStrings.workTogether, 'title'),
            style: isDesktop
                ? AppTextStyles.displayXXXLarge(
                    weight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : AppTextStyles.displayXXLarge(
                    weight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Description
          Text(
            languageController.getText(AppStrings.workTogether, 'description'),
            style: isDesktop
                ? AppTextStyles.bodyLarge(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  )
                : AppTextStyles.bodyMedium(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),

          const SizedBox(height: 40),

          // Action buttons
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Desktop layout - horizontal buttons
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'emailButton'),
                      LucideIcons.mail,
                      true, // primary button
                      () => _launchEmail(),
                      isDesktop,
                    ),
                    const SizedBox(width: 24),
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'githubButton'),
                      LucideIcons.github,
                      false, // secondary button
                      () => _launchGithub(),
                      isDesktop,
                    ),
                    const SizedBox(width: 24),
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'linkedinButton'),
                      LucideIcons.linkedin,
                      false, // secondary button
                      () => _launchLinkedin(),
                      isDesktop,
                    ),
                  ],
                );
              } else {
                // Mobile layout - vertical buttons
                return Column(
                  children: [
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'emailButton'),
                      LucideIcons.mail,
                      true, // primary button
                      () => _launchEmail(),
                      isDesktop,
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'githubButton'),
                      LucideIcons.github,
                      false, // secondary button
                      () => _launchGithub(),
                      isDesktop,
                    ),
                    const SizedBox(height: 16),
                    _buildActionButton(
                      context,
                      languageController.getText(
                          AppStrings.workTogether, 'linkedinButton'),
                      LucideIcons.linkedin,
                      false, // secondary button
                      () => _launchLinkedin(),
                      isDesktop,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String text,
    IconData icon,
    bool isPrimary,
    VoidCallback onTap,
    bool isDesktop,
  ) {
    return Container(
      height: 50,
      constraints: BoxConstraints(minWidth: isDesktop ? 150 : 120),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 24 : 12, vertical: isDesktop ? 12 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isPrimary
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              border: isPrimary
                  ? null
                  : Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: isPrimary
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(text,
                      style: AppTextStyles.bodyMedium(
                        color: isPrimary
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _launchEmail() {
    _launchUrl('mailto:${AppStrings.about['en']!['email']}');
  }

  void _launchGithub() {
    _launchUrl(AppStrings.socialLinks['github'] ?? 'https://github.com');
  }

  void _launchLinkedin() {
    _launchUrl(AppStrings.socialLinks['linkedin'] ?? 'https://linkedin.com');
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
