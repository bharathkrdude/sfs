import 'package:flutter/material.dart';
import 'package:sfs/view/screens/auth/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: 'Quality Education',
      subtitle: 'Unlock your potential with premium educational resources',
      imageUrl:
          'https://img.freepik.com/free-vector/education-learning-concept-love-reading-people-reading-students-studying-preparing-examination-library-book-lovers-readers-modern-literature-flat-cartoon-vector-illustration_1150-61094.jpg',
      backgroundColor: const Color(0xFFE3F2FD),
      titleColor: const Color(0xFF1565C0),
    ),
    OnboardingData(
      title: 'Expert Guidance',
      subtitle: 'Learn from industry professionals and achieve excellence',
      imageUrl:
          'https://img.freepik.com/free-vector/teaching-concept-illustration_114360-1708.jpg',
      backgroundColor: const Color(0xFFFFEBEE),
      titleColor: const Color(0xFFC62828),
    ),
    OnboardingData(
      title: 'Track Progress',
      subtitle: 'Monitor your growth and celebrate achievements',
      imageUrl:
          'https://img.freepik.com/free-vector/college-university-students-group-young-happy-people-standing-isolated-white-background_575670-66.jpg',
      backgroundColor: const Color(0xFFE8EAF6),
      titleColor: const Color(0xFF283593),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingPages.length,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == onboardingPages.length - 1;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(onboardingPages[index]);
            },
          ),
          // Navigation Controls
          SafeArea(
            child: Column(
              children: [
                // Skip button at top right
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () =>
                          _controller.jumpToPage(onboardingPages.length - 1),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Bottom navigation
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Page indicator
                      SmoothPageIndicator(
                        controller: _controller,
                        count: onboardingPages.length,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.grey[300]!,
                          activeDotColor: onboardingPages[_controller.hasClients
                                  ? _controller.page?.round() ?? 0
                                  : 0]
                              .titleColor,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Next/Get Started button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLastPage) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            } else {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: onboardingPages[
                                    _controller.hasClients
                                        ? _controller.page?.round() ?? 0
                                        : 0]
                                .titleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            isLastPage ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Container(
      color: data.backgroundColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            // Image with loading placeholder
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: // Replace the CachedNetworkImage with this optimized version
                    Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Image.network(
                    data.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(data.titleColor),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.error_outline,
                      size: 48,
                      color: data.titleColor,
                    ),
                  ),
                )),
            const Spacer(flex: 1),
            // Text content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      color: data.titleColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Color backgroundColor;
  final Color titleColor;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.backgroundColor,
    required this.titleColor,
  });
}
