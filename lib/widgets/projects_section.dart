import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hamed_portfolio/controllers/language_controller.dart';
import 'package:hamed_portfolio/utils/app_strings.dart';
import 'package:hamed_portfolio/utils/screen_utils.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.7);
  Timer? _autoPlayTimer;

  final List<String> _projectKeys = [
    '2gether',
    'filmator',
    'ardNasr',
    'namjoo'
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _currentIndex = (_currentIndex + 1) % _projectKeys.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _nextPage() {
    _stopAutoPlay();
    if (_currentIndex < _projectKeys.length - 1) {
      _currentIndex++;
    } else {
      _currentIndex = 0;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _startAutoPlay();
  }

  void _previousPage() {
    _stopAutoPlay();
    if (_currentIndex > 0) {
      _currentIndex--;
    } else {
      _currentIndex = _projectKeys.length - 1;
    }
    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _startAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    final languageController = Get.find<LanguageController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.getScreenEdgePadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            languageController.getText(AppStrings.projects, 'title'),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 40),

          // Projects Carousel
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: isDesktop ? 500 : 450,
              maxWidth: 700,
            ),
            //  height: isDesktop ? 500 : 450,

            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _projectKeys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 40.0 : 20.0,
                  ),
                  child: _buildProjectCard(
                    context,
                    languageController,
                    _projectKeys[index],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // Page Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _projectKeys.asMap().entries.map((entry) {
              return Container(
                width: 12.0,
                height: 12.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == entry.key
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _previousPage,
                icon: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                onPressed: _nextPage,
                icon: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                style: IconButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context,
      LanguageController languageController, String projectKey) {
    final project = AppStrings.projectDetails[projectKey]!;
    final hasLink = project['link']?.isNotEmpty == true;

    return Container(
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasLink ? () => _launchUrl(project['link']!) : null,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Header
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.work,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          Text(
                            languageController.currentLanguage == 'fa'
                                ? project['date_fa']!
                                : project['date_en']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (hasLink)
                      Icon(
                        Icons.open_in_new,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Project Description
                Text(
                  languageController.currentLanguage == 'fa'
                      ? project['description_fa']!
                      : project['description_en']!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                        height: 1.6,
                      ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Project Role (if available)
                if (project.containsKey('role_fa') &&
                    project['role_fa']!.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      languageController.currentLanguage == 'fa'
                          ? project['role_fa']!
                          : project['role_en']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),

                const Spacer(),

                // View Project Button
                if (hasLink)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(project['link']!),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        languageController.currentLanguage == 'fa'
                            ? 'مشاهده پروژه'
                            : 'View Project',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}
