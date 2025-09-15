import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      padding: EdgeInsets.all(ScreenUtil.getScreenEdgePadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSectionTitle(context, languageController),
          const SizedBox(height: 40),
          _buildSkillsGrid(context, languageController, isDesktop),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
      BuildContext context, LanguageController languageController) {
    return Text(
      languageController.getText(AppStrings.skills, 'title'),
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context,
      LanguageController languageController, bool isDesktop) {
    final skillsData = _getSkillsData(languageController);

    return isDesktop
        ? IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: SkillCard(
                    title: skillsData[0]['title']!,
                    icon: skillsData[0]['icon']!,
                    skills: skillsData[0]['skills']!,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SkillCard(
                    title: skillsData[1]['title']!,
                    icon: skillsData[1]['icon']!,
                    skills: skillsData[1]['skills']!,
                  ),
                ),
              ],
            ),
          )
        : Column(
            children: skillsData.map((skillData) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 20),
                child: SkillCard(
                  title: skillData['title']!,
                  icon: skillData['icon']!,
                  skills: skillData['skills']!,
                ),
              );
            }).toList(),
          );
  }

  List<Map<String, dynamic>> _getSkillsData(
      LanguageController languageController) {
    return [
      {
        'title': languageController.getText(AppStrings.skills, 'subtitle1'),
        'icon': LucideIcons.building,
        'skills': [
          'Flutter',
          'State management',
          'SOLID',
          'Dependency Injection',
          'Socket.IO',
          'Firebase',
          'Multi Threading',
          'Isolate',
          'REST Communications',
          'Material Components',
          'Custom Components',
          'Flutter Web',
          'Responsive Design',
          'iOS/Android Deployment',
          'Integration Testing',
          'Widget Testing',
          'Documentation',
          'Push notification',
        ],
      },
      {
        'title': languageController.getText(AppStrings.skills, 'subtitle3'),
        'icon': Icons.build,
        'skills': [
          'AirTable',
          'AWS',
          'Bitbucket',
          'Docker',
          'Figma',
          'Firebase',
          'Github',
          'Gitlab',
          'GIT / CI-CD',
          'Google Map APi',
          'GraphQL',
          'Jira',
          'MongoDB',
          'MySQL',
          'Notion',
          'Open Ai API',
          'REST',
          'Slack',
          'Socket.IO',
          'Trello',
          'WebSocket',
        ],
      },
    ];
  }
}

class SkillCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCard({
    required this.title,
    required this.icon,
    required this.skills,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _animationController.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _animationController.reverse();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
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
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isHovered
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2)
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),

                  // Skills List
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      //   maxWidth: 400,
                      maxHeight: 1000,
                      // Set a maximum height for the skills list
                    ),
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: widget.skills.map((skill) {
                        final index = widget.skills.indexOf(skill);
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 100 + (index * 50)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isHovered
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1)
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant
                                    .withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            skill,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
