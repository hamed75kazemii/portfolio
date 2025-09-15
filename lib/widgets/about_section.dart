import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final languageController = Get.find<LanguageController>();
  late bool isDesktop;
  @override
  Widget build(BuildContext context) {
    isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 40, horizontal: ScreenUtil.getScreenEdgePadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSectionTitle(),
          const SizedBox(height: 40),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return Text(
      languageController.getText(AppStrings.about, 'title'),
      style: AppTextStyles.displayXXLarge(
        weight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  _buildContent() {
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: _buildDescription()),
          const SizedBox(width: 40),
          Expanded(flex: 4, child: _buildPersonalSkill()),
        ],
      );
    } else {
      return Column(
        children: [
          _buildDescription(),
          const SizedBox(height: 40),
          _buildPersonalSkill(),
        ],
      );
    }
  }

  Widget _buildPersonalSkill() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      direction: Axis.horizontal,
      children: [
        _buildAboutSkillItem(
          context,
          LucideIcons.code,
          languageController.getText(
            AppStrings.aboutSkills,
            'skill1',
          ),
          languageController.getText(AppStrings.aboutSkills, 'description1'),
        ),
        _buildAboutSkillItem(
          context,
          LucideIcons.penTool,
          languageController.getText(AppStrings.aboutSkills, 'skill2'),
          languageController.getText(AppStrings.aboutSkills, 'description2'),
        ),
        _buildAboutSkillItem(
          context,
          LucideIcons.table2,
          languageController.getText(AppStrings.aboutSkills, 'skill3'),
          languageController.getText(AppStrings.aboutSkills, 'description3'),
        ),
        _buildAboutSkillItem(
          context,
          LucideIcons.rocket,
          languageController.getText(AppStrings.aboutSkills, 'skill4'),
          languageController.getText(AppStrings.aboutSkills, 'description4'),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.getText(AppStrings.about, 'description'),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: Theme.of(context).colorScheme.onBackground,
              ),
          //textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24),

        // Skills Preview
        Wrap(
          spacing: isDesktop ? 12 : 8,
          runSpacing: 8,
          children: [
            'Flutter',
            'Dart',
            'Mobile Development',
            'Web Development',
            'PWA',
            'Firebase',
            'Socket.IO',
            'REST API',
            'GraphQL',
            'State Management',
          ]
              .map((skill) => Chip(
                    label: Text(skill),
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildAboutSkillItem(
      BuildContext context, IconData icon, String text, String description) {
    return AboutSkillItem(
      icon: icon,
      text: text,
      description: description,
    );
  }
}

class AboutSkillItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final String description;

  const AboutSkillItem({
    super.key,
    required this.icon,
    required this.text,
    required this.description,
  });

  @override
  State<AboutSkillItem> createState() => AboutSkillItemState();
}

class AboutSkillItemState extends State<AboutSkillItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isDesktop
              ? (screenwidth -
                      (40 +
                          24 +
                          2 * ScreenUtil.getScreenEdgePadding(context))) *
                  2 /
                  7
              : (screenwidth -
                      (ScreenUtil.getScreenEdgePadding(context) * 2 + 2 * 6)) /
                  2,
          height: isDesktop ? screenheight / 3.2 : screenheight / 2.7,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHovered
                ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
            border: Border.all(
              color: isHovered
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                  : Theme.of(context).colorScheme.outline.withOpacity(0.2),
              width: isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.primary,
                size: isDesktop ? 40 : 30,
                shadows: isHovered
                    ? [
                        Shadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              SizedBox(height: isDesktop ? 12 : 8),
              Text(
                widget.text,
                style: isDesktop
                    ? AppTextStyles.bodyLarge(
                        color: Theme.of(context).colorScheme.onBackground,
                        weight: isHovered ? FontWeight.w600 : FontWeight.normal,
                      )
                    : AppTextStyles.bodyMedium(
                        color: Theme.of(context).colorScheme.onBackground,
                        weight: isHovered ? FontWeight.w600 : FontWeight.normal,
                      ),
              ),
              SizedBox(height: isDesktop ? 12 : 5),
              Text(
                widget.description,
                style: isDesktop
                    ? AppTextStyles.bodyXMedium(
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : AppTextStyles.bodySmall(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
