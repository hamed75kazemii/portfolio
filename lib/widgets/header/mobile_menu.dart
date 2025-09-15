import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/home_controller.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/controllers/theme_controller.dart';
import 'package:hamed_portfolio/method/tap_handler.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:hamed_portfolio/utils/section_enum.dart';

class MobileMenu extends StatefulWidget {
  const MobileMenu({
    super.key,
  });

  @override
  State<MobileMenu> createState() => _MobileMenuState();
}

class _MobileMenuState extends State<MobileMenu> {
  late HomeController homeController;
  late LanguageController languageController;
  late ThemeController themeController;

  @override
  void initState() {
    super.initState();
    languageController = Get.find<LanguageController>();
    themeController = Get.find<ThemeController>();
    homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color:
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _customTile('about'),
                _customTile('skills'),
                _customTile('projects'),
                _customTile('contact'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _customTile(String title) {
    return TapHandler(
      onTap: () {
        Section? section;
        switch (title) {
          case 'about':
            section = Section.about;
            break;
          case 'skills':
            section = Section.skills;
            break;
          case 'projects':
            section = Section.projects;
            break;
          case 'contact':
            section = Section.workTogether;
            break;
        }

        if (section != null) {
          homeController.scrollTo(section);
        }
        homeController.closeMenu();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
            AppStrings.navigation[languageController.currentLanguage]?[title] ??
                title,
            style: AppTextStyles.bodyMedium(
                color:
                    themeController.isDarkMode ? Colors.white : Colors.black)),
      ),
    );
  }
}
