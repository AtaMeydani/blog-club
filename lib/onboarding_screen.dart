import 'package:blog_club/data.dart';
import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final items = AppDatabase.onboardingItems;
  final PageController _pageController = PageController();
  int page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.toInt() != page) {
        setState(() {
          page = _pageController.page!.toInt();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 8),
                child: Assets.img.background.onboarding.image(),
              ),
            ),
            Container(
              height: 260,
              decoration: BoxDecoration(
                color: themeData.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: items.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                items[index].title,
                                style: themeData.textTheme.headlineMedium,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                items[index].description,
                                style: themeData.textTheme.titleMedium!.apply(fontSizeFactor: .9),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: items.length,
                          effect: ExpandingDotsEffect(
                            dotWidth: 8,
                            dotHeight: 8,
                            activeDotColor: themeData.colorScheme.primary,
                            dotColor: themeData.colorScheme.primary.withOpacity(.1),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (page == items.length - 1) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } else {
                              _pageController.animateToPage(
                                page + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: const MaterialStatePropertyAll(Size(84, 60)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          child: Icon(
                            page == items.length - 1 ? CupertinoIcons.check_mark : CupertinoIcons.arrow_right,
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
      ),
    );
  }
}
