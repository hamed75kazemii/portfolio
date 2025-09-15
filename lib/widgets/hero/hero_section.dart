import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/controllers/home_controller.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/controllers/theme_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/app_text.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';
import 'package:hamed_portfolio/widgets/hero/animated_circle.dart';
import 'package:hamed_portfolio/widgets/hero/animated_opacity_circle.dart';
import 'package:hamed_portfolio/widgets/hero/animted_typing_text.dart';
import 'package:hamed_portfolio/widgets/hero/hero_social_icons.dart';
import 'package:hamed_portfolio/widgets/hero/grid_layer.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({
    super.key,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late ThemeController themeController;
  late LanguageController languageController;
  late HomeController homeController;
  @override
  void initState() {
    super.initState();
    themeController = Get.find<ThemeController>();
    languageController = Get.find<LanguageController>();
    homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedCirclesWidget()),
          ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  color: Colors.transparent,
                )),
          ),
          const GridLayer(),
          const AnimatedCircle(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil.getScreenEdgePadding(context)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Text(
                    languageController.getText(AppStrings.home, 'title'),
                    style: isDesktop
                        ? AppTextStyles.displayXXXLarge(
                            weight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : AppTextStyles.displayXXLarge(
                            weight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const AnimatedTypingText(),
                  const Spacer(),
                  Text(
                    languageController.getText(AppStrings.home, 'description'),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            homeController.scrollToProjects();
                          },
                          child: Container(
                            width: isDesktop ? 150 : 120,
                            height: isDesktop ? 50 : 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            child: Center(
                              child: Text(
                                languageController.getText(
                                    AppStrings.home, 'cta1'),
                                style: isDesktop
                                    ? AppTextStyles.bodyMedium(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )
                                    : AppTextStyles.bodyXMedium(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                              ),
                            ),
                          )),
                      const SizedBox(width: 32),
                      InkWell(
                        onTap: () {
                          homeController.scrollToWorkTogether();
                        },
                        child: Container(
                          width: isDesktop ? 150 : 120,
                          height: isDesktop ? 50 : 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              languageController.getText(
                                  AppStrings.home, 'cta2'),
                              style: isDesktop
                                  ? AppTextStyles.bodyMedium(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  : AppTextStyles.bodyXMedium(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const HeroSocialIcons(),
                  const Spacer(),
                  const Spacer(),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: homeController.heroStats.map<Widget>((stat) {
                        return _buildHeroTiles(
                            title: languageController.getText(
                                AppStrings.home, stat['titleKey']!),
                            value: stat['value']!,
                            isDesktop: isDesktop);
                      }).toList()),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHeroTiles(
      {required String title, required String value, required bool isDesktop}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Text(
              value,
              style: isDesktop
                  ? AppTextStyles.displayLarge(
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.bold,
                    )
                  : AppTextStyles.displayMedium(
                      color: Theme.of(context).colorScheme.primary,
                      weight: FontWeight.bold,
                    ),
            ),
            const SizedBox(height: 16),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: isDesktop
                    ? AppTextStyles.bodyMedium(
                        color: Theme.of(context).colorScheme.onSurface,
                      )
                    : AppTextStyles.bodyXMedium(
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
          ],
        ),
      ),
    );
  }
}
