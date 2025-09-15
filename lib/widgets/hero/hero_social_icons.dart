import 'package:flutter/material.dart';
import 'package:hamed_portfolio/method/tap_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HeroSocialIcons extends StatelessWidget {
  const HeroSocialIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 800;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(
          context,
          LucideIcons.mail,
          () => _launchEmail(),
          isDesktop,
        ),
        _buildSocialIcon(
          context,
          LucideIcons.github,
          () => _launchGithub(),
          isDesktop,
        ),
        _buildSocialIcon(
          context,
          LucideIcons.linkedin,
          () => _launchLinkedin(),
          isDesktop,
        ),
        _buildSocialIcon(
          context,
          LucideIcons.instagram,
          () => _launchInstagram(),
          isDesktop,
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    VoidCallback onTap,
    bool isDesktop,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 12 : 8),
      width: isDesktop ? 70 : 60,
      height: isDesktop ? 70 : 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: StatefulBuilder(builder: (context, setState) {
        return Material(
          color: Colors.transparent,
          child: TapHandler(
            borderRadius: 100,
            onTap: onTap,
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.onSurface,
              size: isDesktop ? 30 : 24,
            ),
          ),
        );
      }),
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

  void _launchInstagram() {
    _launchUrl(AppStrings.socialLinks['instagram'] ?? 'https://instagram.com');
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
