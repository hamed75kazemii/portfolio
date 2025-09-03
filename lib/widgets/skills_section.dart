import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
            languageController.getText(AppStrings.skills, 'title'),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 40),

          // Skills Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 800 ? 3 : 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.2,
            children: [
              _buildSkillCard(context, languageController, 'flutter',
                  Icons.mobile_friendly),
              _buildSkillCard(context, languageController, 'stateManagement',
                  Icons.manage_accounts),
              _buildSkillCard(
                  context, languageController, 'solid', Icons.architecture),
              _buildSkillCard(context, languageController, 'di',
                  Icons.integration_instructions),
              _buildSkillCard(
                  context, languageController, 'firebase', Icons.cloud),
              _buildSkillCard(
                  context, languageController, 'multithreading', Icons.sync),
              _buildSkillCard(context, languageController, 'rest', Icons.api),
              _buildSkillCard(
                  context, languageController, 'components', Icons.widgets),
              _buildSkillCard(context, languageController, 'web', Icons.web),
              _buildSkillCard(context, languageController, 'responsive',
                  Icons.phone_android),
              _buildSkillCard(context, languageController, 'deployment',
                  Icons.rocket_launch),
              _buildSkillCard(context, languageController, 'git', Icons.source),
              _buildSkillCard(
                  context, languageController, 'testing', Icons.bug_report),
              _buildSkillCard(context, languageController, 'documentation',
                  Icons.description),
              _buildSkillCard(
                  context, languageController, 'javascript', Icons.code),
              _buildSkillCard(
                  context, languageController, 'nodejs', Icons.code),
              _buildSkillCard(context, languageController, 'pushNotification',
                  Icons.notifications),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context,
      LanguageController languageController, String skillKey, IconData icon) {
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              languageController.getText(AppStrings.skills, skillKey),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
