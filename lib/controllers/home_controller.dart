import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamed_portfolio/utils/section_enum.dart';

class HomeController extends GetxController {
  final _isOpenMenu = false.obs;
  final _isShowScrollToTop = false.obs;
  final _isShowAppBar = true.obs;

  // Scroll tracking
  double _lastScrollPosition = 0.0;
  final double _hideThreshold = 100.0;

  // GlobalKeys for sections
  final Map<Section, GlobalKey> sectionKeys = {
    Section.hero: GlobalKey(),
    Section.about: GlobalKey(),
    Section.skills: GlobalKey(),
    Section.projects: GlobalKey(),
    Section.workTogether: GlobalKey(),
    Section.footer: GlobalKey(),
  };

  bool get isOpenMenu => _isOpenMenu.value;
  bool get isShowScrollToTop => _isShowScrollToTop.value;
  bool get isShowAppBar => _isShowAppBar.value;

  set isShowScrollToTop(bool value) {
    _isShowScrollToTop.value = value;
  }

  set isShowAppBar(bool value) {
    _isShowAppBar.value = value;
  }

  // Hero statistics data
  final List<Map<String, String>> heroStats = [
    {
      'titleKey': 'yearsExperience',
      'value': '+7',
    },
    {
      'titleKey': 'projectsCompleted',
      'value': '+10',
    },
    {
      'titleKey': 'clientSatisfaction',
      'value': '+100',
    },
  ];

  @override
  void onInit() {
    super.onInit();

    _isOpenMenu.value = false;
    _isShowScrollToTop.value = false;
    _isShowAppBar.value = true;
  }

  void toggleMap() {
    _isOpenMenu.value = !_isOpenMenu.value;
  }

  void closeMenu() {
    _isOpenMenu.value = false;
  }

  // Method to get GlobalKey for a section
  GlobalKey getSectionKey(Section section) {
    return sectionKeys[section]!;
  }

  // Scroll to specific section
  void scrollTo(Section section) {
    final context = sectionKeys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  // Convenience methods for backward compatibility
  void scrollToAbout() => scrollTo(Section.about);
  void scrollToSkills() => scrollTo(Section.skills);
  void scrollToProjects() => scrollTo(Section.projects);
  void scrollToWorkTogether() => scrollTo(Section.workTogether);
  void scrollToFooter() => scrollTo(Section.footer);

  // Handle scroll for app bar visibility
  void handleScroll(double currentPosition) {
    // Hide app bar when scrolling down past threshold
    if (currentPosition > _hideThreshold &&
        currentPosition > _lastScrollPosition) {
      _isShowAppBar.value = false;
    }
    // Show app bar immediately when scrolling up
    else if (currentPosition < _lastScrollPosition) {
      _isShowAppBar.value = true;
    }

    _lastScrollPosition = currentPosition;
  }
}
