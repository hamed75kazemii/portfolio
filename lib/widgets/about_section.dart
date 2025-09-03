import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            languageController.getText(AppStrings.about, 'title'),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 40),

          // Content Row
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                // Desktop layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side - Personal Info
                    Expanded(
                      flex: 1,
                      child: _buildPersonalInfo(context, languageController),
                    ),
                    const SizedBox(width: 40),
                    // Right side - Description
                    Expanded(
                      flex: 2,
                      child: _buildDescription(context, languageController),
                    ),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPersonalInfo(context, languageController),
                    const SizedBox(height: 30),
                    _buildDescription(context, languageController),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo(
      BuildContext context, LanguageController languageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image Placeholder
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),

        // Personal Details
        _buildInfoRow(
          context,
          Icons.person,
          languageController.getText(AppStrings.about, 'name'),
        ),
        _buildInfoRow(
          context,
          Icons.work,
          languageController.getText(AppStrings.about, 'role'),
        ),
        _buildInfoRow(
          context,
          Icons.email,
          languageController.getText(AppStrings.about, 'email'),
        ),
        _buildInfoRow(
          context,
          Icons.phone,
          languageController.getText(AppStrings.about, 'phone'),
        ),
        _buildInfoRow(
          context,
          Icons.location_on,
          languageController.getText(AppStrings.about, 'location'),
        ),
      ],
    );
  }

  Widget _buildDescription(
      BuildContext context, LanguageController languageController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          languageController.getText(AppStrings.about, 'description'),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: Theme.of(context).colorScheme.onBackground,
              ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 24),

        // Skills Preview
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            'Flutter',
            'Dart',
            'Mobile Development',
            'Web Development',
            'PWA',
            'Firebase',
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

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
