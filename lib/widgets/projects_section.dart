import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
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
  final PageController _pageController = PageController(viewportFraction: 0.85);
  Timer? _autoPlayTimer;
  Map<String, VideoPlayerController?> _videoControllers = {};

  final List<String> _projectKeys = [
    '2gether',
    'prochef',
    'filmator',
    'ardNasr',
    'namjoo',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
    _initializeVideoControllers();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    _disposeVideoControllers();
    super.dispose();
  }

  void _initializeVideoControllers() {
    // Don't initialize video controllers here to avoid memory issues
    // Initialize them only when needed in the dialog
  }

  void _disposeVideoControllers() {
    if (_videoControllers.isNotEmpty) {
      for (var entry in _videoControllers.entries) {
        try {
          entry.value?.dispose();
        } catch (e) {
          print('Error disposing video controller for ${entry.key}: $e');
        }
      }
      _videoControllers.clear();
    }
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
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
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 800 && screenWidth <= 1200;
    final isMobile = screenWidth <= 800;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil.getScreenEdgePadding(context),
        horizontal: isDesktop ? 40 : 20,
      ),
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
          const SizedBox(height: 60),

          // Projects Grid/Carousel
          _buildProjectsDisplay(
              context, languageController, isDesktop, isTablet, isMobile),

          const SizedBox(height: 40),

          // Page Indicators
          if (!isDesktop) _buildPageIndicators(context),

          const SizedBox(height: 30),

          // Navigation Buttons (only for mobile/tablet)
          if (!isDesktop) _buildNavigationButtons(context),
        ],
      ),
    );
  }

  Widget _buildProjectsDisplay(
    BuildContext context,
    LanguageController languageController,
    bool isDesktop,
    bool isTablet,
    bool isMobile,
  ) {
    if (isDesktop) {
      // Desktop: Show grid layout
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: _projectKeys.length,
        itemBuilder: (context, index) {
          return _buildProjectCard(
            context,
            languageController,
            _projectKeys[index],
            isDesktop: true,
            isMobile: isMobile,
          );
        },
      );
    } else {
      // Mobile/Tablet: Show carousel
      return SizedBox(
        height: isTablet ? 580 : 380,
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
                horizontal: isTablet ? 30.0 : 15.0,
              ),
              child: _buildProjectCard(
                context,
                languageController,
                _projectKeys[index],
                isDesktop: false,
                isMobile: isMobile,
              ),
            );
          },
        ),
      );
    }
  }

  Widget _buildPageIndicators(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _projectKeys.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentIndex == entry.key ? 24.0 : 12.0,
          height: 12.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: _currentIndex == entry.key
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavButton(
          context,
          icon: Icons.arrow_back_ios,
          onPressed: _previousPage,
        ),
        const SizedBox(width: 20),
        _buildNavButton(
          context,
          icon: Icons.arrow_forward_ios,
          onPressed: _nextPage,
        ),
      ],
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    LanguageController languageController,
    String projectKey, {
    required bool isDesktop,
    required bool isMobile,
  }) {
    final project = AppStrings.projectDetails[projectKey]!;
    final hasVideo = project['video_url']?.isNotEmpty == true;
    final hasAppStore = project['app_store']?.isNotEmpty == true;
    final hasGooglePlay = project['google_play']?.isNotEmpty == true;
    final hasGithub = project['github']?.isNotEmpty == true;
    final isPrivate = project['is_private'] == 'true';
    final status = languageController.currentLanguage == 'fa'
        ? project['status_fa']!
        : project['status_en']!;
    final isCompleted =
        status.contains('Completed') || status.contains('تکمیل');
    final image =
        project['image']?.isNotEmpty == true ? project['image']! : null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface.withOpacity(0.8),
            Theme.of(context).colorScheme.surface.withOpacity(0.5),
          ],
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () =>
              _showProjectDetails(context, languageController, projectKey),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Project Header with Status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted ? Colors.green : Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            status,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isCompleted
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (image != null)
                            SizedBox(
                              width: isMobile ? 50 : 70,
                              height: isMobile ? 50 : 70,
                              child: Center(child: Image.asset(image)),
                            ),
                          SizedBox(width: isMobile ? 12 : 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project['title']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: isMobile ? 18 : 20,
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
                                      fontSize: isMobile ? 12 : 14,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (hasVideo)
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                              ),
                              child: IconButton(
                                onPressed: () =>
                                    _showVideoPlayer(context, projectKey),
                                icon: Icon(
                                  Icons.play_circle_filled,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: isMobile ? 20 : 24,
                                ),
                                padding: EdgeInsets.all(isMobile ? 8 : 12),
                                constraints: BoxConstraints(
                                  minWidth: isMobile ? 33 : 44,
                                  minHeight: isMobile ? 33 : 44,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

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
                        height: 1.5,
                        fontSize: isMobile ? 13 : 14,
                      ),
                  maxLines: isDesktop ? 3 : 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // Project Role (if available)
                if (project.containsKey('role_fa') &&
                    project['role_fa']!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 12 : 16,
                      vertical: isMobile ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      languageController.currentLanguage == 'fa'
                          ? project['role_fa']!
                          : project['role_en']!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 10 : 11,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                const Spacer(),
                // Action Buttons
                _buildActionButtons(
                  context,
                  languageController,
                  project,
                  hasAppStore,
                  hasGooglePlay,
                  hasGithub,
                  isPrivate,
                  isMobile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    LanguageController languageController,
    Map<String, String> project,
    bool hasAppStore,
    bool hasGooglePlay,
    bool hasGithub,
    bool isPrivate,
    bool isMobile,
  ) {
    final buttonCount =
        [hasAppStore, hasGooglePlay, hasGithub].where((has) => has).length;

    if (buttonCount == 0) return const SizedBox.shrink();

    return Wrap(
      spacing: isMobile ? 6 : 8,
      runSpacing: isMobile ? 6 : 8,
      children: [
        // App Store Button
        if (hasAppStore)
          _buildActionButton(
            context,
            icon: Icons.apple,
            label: 'App Store',
            onPressed: () => _launchUrl(project['app_store']!),
            color: Colors.black,
            isPrivate: false,
            isMobile: isMobile,
          ),

        // Google Play Button
        if (hasGooglePlay)
          _buildActionButton(
            context,
            icon: Icons.android,
            label: 'Google Play',
            onPressed: () => _launchUrl(project['google_play']!),
            color: Colors.green,
            isPrivate: false,
            isMobile: isMobile,
          ),

        // GitHub Button
        if (hasGithub)
          _buildActionButton(
            context,
            icon: isPrivate ? Icons.lock : Icons.code,
            label: 'GitHub',
            onPressed: isPrivate ? null : () => _launchUrl(project['github']!),
            color:
                isPrivate ? Colors.grey : Theme.of(context).colorScheme.primary,
            isPrivate: isPrivate,
            isMobile: isMobile,
          ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
    required bool isPrivate,
    required bool isMobile,
  }) {
    return Container(
      constraints: BoxConstraints(
        minWidth: isMobile ? 80 : 120,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: isMobile ? 14 : 20,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 10 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              onPressed != null ? color : Colors.grey.withOpacity(0.3),
          foregroundColor: onPressed != null ? Colors.white : Colors.grey[600],
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 8 : 10,
            horizontal: isMobile ? 8 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: onPressed != null ? 2 : 0,
        ),
      ),
    );
  }

  void _showProjectDetails(
    BuildContext context,
    LanguageController languageController,
    String projectKey,
  ) {
    showDialog(
      context: context,
      builder: (context) => _ProjectDetailsDialog(
        projectKey: projectKey,
        languageController: languageController,
      ),
    );
  }

  void _showVideoPlayer(BuildContext context, String projectKey) {
    final project = AppStrings.projectDetails[projectKey]!;
    final videoUrl = project['video_url'];

    if (videoUrl != null && videoUrl.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => _VideoPlayerDialog(
          videoUrl: videoUrl,
          projectTitle: project['title']!,
        ),
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }
}

class _ProjectDetailsDialog extends StatelessWidget {
  final String projectKey;
  final LanguageController languageController;

  const _ProjectDetailsDialog({
    required this.projectKey,
    required this.languageController,
  });

  @override
  Widget build(BuildContext context) {
    final project = AppStrings.projectDetails[projectKey]!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    project['title']!,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              languageController.currentLanguage == 'fa'
                  ? project['description_fa']!
                  : project['description_en']!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoPlayerDialog extends StatefulWidget {
  final String videoUrl;
  final String projectTitle;

  const _VideoPlayerDialog({
    required this.videoUrl,
    required this.projectTitle,
  });

  @override
  State<_VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<_VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }).catchError((error) {
        print('Error initializing video: $error');
        if (mounted) {
          setState(() {
            _isInitialized = false;
          });
        }
      });
  }

  @override
  void dispose() {
    try {
      _controller.dispose();
    } catch (e) {
      print('Error disposing video controller: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.projectTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _isInitialized
                    ? Stack(
                        children: [
                          VideoPlayer(_controller),
                          Center(
                            child: IconButton(
                              onPressed: () {
                                if (mounted &&
                                    _controller.value.isInitialized) {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                }
                              },
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading video...'),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
