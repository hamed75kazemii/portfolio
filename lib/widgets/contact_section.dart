import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();

    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            languageController.getText(AppStrings.contact, 'title'),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 40),

          // Contact Content
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // Desktop layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Contact Info
                    Expanded(
                      flex: 1,
                      child: _buildContactInfo(context, languageController),
                    ),
                    const SizedBox(width: 40),
                    // Right side - Social Media
                    Expanded(
                      flex: 1,
                      child: _buildSocialMedia(context, languageController),
                    ),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfo(context, languageController),
                    const SizedBox(height: 30),
                    _buildSocialMedia(context, languageController),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, LanguageController languageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.currentLanguage == 'fa'
              ? 'اطلاعات تماس'
              : 'Contact Information',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 24),
        _buildContactRow(
          context,
          Icons.email,
          languageController.getText(AppStrings.about, 'email'),
          () => _launchUrl(
              'mailto:${languageController.getText(AppStrings.about, 'email')}'),
        ),
        _buildContactRow(
          context,
          Icons.phone,
          languageController.getText(AppStrings.about, 'phone'),
          () => _launchUrl(
              'tel:${languageController.getText(AppStrings.about, 'phone')}'),
        ),
        _buildContactRow(
          context,
          Icons.location_on,
          languageController.getText(AppStrings.about, 'location'),
          null,
        ),
      ],
    );
  }

  Widget _buildSocialMedia(
      BuildContext context, LanguageController languageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.getText(AppStrings.contact, 'socialMedia'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 24),

        // Social Media Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            _buildSocialCard(
                context, 'instagram', Icons.camera_alt, Colors.purple),
            _buildSocialCard(context, 'telegram', Icons.send, Colors.blue),
            _buildSocialCard(
                context, 'linkedin', Icons.work, Colors.blue.shade700),
          ],
        ),
      ],
    );
  }

  Widget _buildContactRow(
      BuildContext context, IconData icon, String text, VoidCallback? onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialCard(
      BuildContext context, String platform, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(AppStrings.socialLinks[platform]!),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.contact[Get.find<LanguageController>()
                      .currentLanguage]![platform]!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
