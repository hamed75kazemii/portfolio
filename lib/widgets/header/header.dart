import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/home_controller.dart';
import 'package:hamed_portfolio/method/screen_responsive.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/utils/section_enum.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageToggle;
  final bool isDarkMode;
  final String currentLanguage;

  const AppHeader({
    super.key,
    required this.onThemeToggle,
    required this.onLanguageToggle,
    required this.isDarkMode,
    required this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 12 : 0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onLanguageToggle,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.language,
                        color: isDarkMode
                            ? Colors.white.withValues(alpha: 0.8)
                            : Colors.black.withValues(alpha: 0.8),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Theme Toggle
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onThemeToggle,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDarkMode
                          ? [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                            ]
                          : [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: isDarkMode
                          ? [
                              BoxShadow(
                                color: Colors.yellow.shade500
                                    .withValues(alpha: 0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color:
                                    Colors.blue.shade900.withValues(alpha: 0.5),
                                blurRadius: 20,
                                offset: const Offset(0, 0),
                              ),
                            ],
                    ),
                    child: Icon(
                      isDarkMode
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: isDarkMode
                          ? Colors.yellow.shade500
                          : Colors.blue.shade900,
                      size: 20,
                      weight: 100,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle(
      {super.key,
      required this.isDarkMode,
      required this.currentLanguage,
      required this.openMenu});
  final bool isDarkMode;
  final String currentLanguage;
  final VoidCallback openMenu;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = MediaQuery.of(context).size.width > 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 16),
      child: isMobile(screenWidth)
          ? InkWell(onTap: openMenu, child: const Icon(Icons.menu))
          : Row(
              children: [
                // App Title for desktop

                // Navigation items
                _buildNavItem(
                    'about', Section.about, currentLanguage, isDarkMode),
                const SizedBox(width: 16),
                _buildNavItem(
                    'projects', Section.projects, currentLanguage, isDarkMode),
                const SizedBox(width: 16),
                _buildNavItem(
                    'skills', Section.skills, currentLanguage, isDarkMode),
                const SizedBox(width: 16),
                _buildNavItem('contact', Section.workTogether, currentLanguage,
                    isDarkMode),
              ],
            ),
    );
  }

  Widget _buildNavItem(String titleKey, Section section, String currentLanguage,
      bool isDarkMode) {
    final homeController = Get.find<HomeController>();
    return InkWell(
      onTap: () => homeController.scrollTo(section),
      child: Text(
        AppStrings.navigation[currentLanguage]?[titleKey] ?? titleKey,
        style: AppTextStyles.bodyMedium(
            color: isDarkMode ? Colors.white : Colors.black),
      ),
    );
  }
}
