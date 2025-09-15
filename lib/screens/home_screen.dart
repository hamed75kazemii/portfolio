import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/home_controller.dart';
import 'package:hamed_portfolio/controllers/theme_controller.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/method/tap_handler.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:hamed_portfolio/utils/section_enum.dart';
import 'package:hamed_portfolio/widgets/hero/hero_section.dart';
import 'package:hamed_portfolio/widgets/about_section.dart';
import 'package:hamed_portfolio/widgets/header/mobile_menu.dart';
import 'package:hamed_portfolio/widgets/skills_section.dart';
import 'package:hamed_portfolio/widgets/projects_section.dart';
import 'package:hamed_portfolio/widgets/footer_section.dart';
import 'package:hamed_portfolio/widgets/header/header.dart';
import 'package:hamed_portfolio/widgets/work_together_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Controllers
  late LanguageController languageController;
  late ThemeController themeController;
  late HomeController homeController;

  //Scroll Controller
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    languageController = Get.find<LanguageController>();
    themeController = Get.find<ThemeController>();
    homeController = Get.find<HomeController>();
    scrollController = ScrollController();
    scrollController.addListener(() {
      // Handle app bar visibility
      homeController.handleScroll(scrollController.offset);

      // Handle scroll to top button
      if (scrollController.offset > 200) {
        homeController.isShowScrollToTop = true;
      } else {
        homeController.isShowScrollToTop = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            slivers: [
              // Home Hero Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.hero),
                child: const HeroSection(),
              ),

              // About Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.about),
                child: const AboutSection(),
              ),

              // Skills Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.skills),
                child: const SizedBox(child: SkillsSection()),
              ),

              // Projects Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.projects),
                child: const ProjectsSection(),
              ),

              // Work Together Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.workTogether),
                child: const WorkTogetherSection(),
              ),

              // Footer Section
              SliverToBoxAdapter(
                key: homeController.getSectionKey(Section.footer),
                child: const FooterSection(),
              ),
            ],
          ),

          // Pinned Header
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: homeController.isShowAppBar ? 0 : -80,
                left: 0,
                right: 0,
                child: _buildPinnedHeader(),
              )),
          Obx(
            () {
              if (homeController.isOpenMenu) {
                return Positioned(
                    top: kToolbarHeight + 20,
                    left: ScreenUtil.getScreenEdgePadding(context),
                    right: ScreenUtil.getScreenEdgePadding(context),
                    child: const MobileMenu());
              } else {
                return const SizedBox();
              }
            },
          ),
          Obx(() {
            if (scrollController.hasClients &&
                homeController.isShowScrollToTop) {
              return Positioned(
                  bottom: 15,
                  left: languageController.currentLanguage == 'fa' ? 15 : null,
                  right: languageController.currentLanguage == 'en' ? 15 : null,
                  child: TapHandler(
                    onTap: () {
                      scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: isDesktop ? 60 : 50,
                          height: isDesktop ? 60 : 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary
                                  .withValues(alpha: 0.1),
                            ),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ));
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildPinnedHeader() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .outline
                    .withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: AppHeader(
                      onThemeToggle: themeController.toggleTheme,
                      onLanguageToggle: languageController.toggleLanguage,
                      isDarkMode: themeController.isDarkMode,
                      currentLanguage: languageController.currentLanguage,
                    ),
                  ),
                  AppTitle(
                    isDarkMode: themeController.isDarkMode,
                    currentLanguage: languageController.currentLanguage,
                    openMenu: homeController.toggleMap,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
