import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/theme_controller.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/widgets/glassmorphic_app_bar.dart';
import 'package:hamed_portfolio/widgets/about_section.dart';
import 'package:hamed_portfolio/widgets/skills_section.dart';
import 'package:hamed_portfolio/widgets/projects_section.dart';
import 'package:hamed_portfolio/widgets/experience_section.dart';
import 'package:hamed_portfolio/widgets/education_section.dart';
import 'package:hamed_portfolio/widgets/contact_section.dart';
import 'package:hamed_portfolio/widgets/theme_language_switcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final languageController = Get.find<LanguageController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Glassmorphic AppBar with gradient and backdrop filter
          GlassmorphicAppBar(
            title: languageController.getText(AppStrings.home, 'title'),
            subtitle: languageController.getText(AppStrings.home, 'subtitle'),
            actions: [
              ThemeLanguageSwitcher(
                onThemeToggle: themeController.toggleTheme,
                onLanguageToggle: languageController.toggleLanguage,
                isDarkMode: themeController.isDarkMode,
                currentLanguage: languageController.currentLanguage,
              ),
            ],
          ),

          // Home Hero Section
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      languageController.getText(AppStrings.home, 'title'),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      languageController.getText(AppStrings.home, 'subtitle'),
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      languageController.getText(
                          AppStrings.home, 'description'),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // Scroll to about section
                        Scrollable.ensureVisible(
                          context.findAncestorStateOfType<State>()?.context ??
                              context,
                          duration: const Duration(milliseconds: 800),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        languageController.getText(AppStrings.home, 'cta'),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // About Section
          const SliverToBoxAdapter(
            child: AboutSection(),
          ),

          // Skills Section
          const SliverToBoxAdapter(
            child: SkillsSection(),
          ),

          // Projects Section
          const SliverToBoxAdapter(
            child: ProjectsSection(),
          ),

          // Experience Section
          const SliverToBoxAdapter(
            child: ExperienceSection(),
          ),

          // Education Section
          const SliverToBoxAdapter(
            child: EducationSection(),
          ),

          // Contact Section
          const SliverToBoxAdapter(
            child: ContactSection(),
          ),
        ],
      ),
    );
  }
}
