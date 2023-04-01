import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/profile_screen.dart';
import 'package:blog_club/search_screen.dart';
import 'package:flutter/material.dart';

import 'article_screen.dart';
import 'home_screen.dart';

const int homeIndex = 0;
const int articleIndex = 1;
const int searchIndex = 2;
const int profileIndex = 3;
const double bottomNavigationHeight = 65;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: bottomNavigationHeight,
            child: IndexedStack(
              index: currentScreenIndex,
              children: const [
                HomeScreen(),
                ArticleScreen(),
                SearchScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomNavigation(
              currentIndex: currentScreenIndex,
              onTap: (int index) {
                setState(() {
                  currentScreenIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  final Function(int index) onTap;
  final int currentIndex;

  const _BottomNavigation({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: bottomNavigationHeight,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: const Color(0x009B8487).withOpacity(.3),
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ButtomNavigationItem(
                  iconFileName: 'Home.png',
                  activeIconFileName: 'HomeActive.png',
                  title: 'Home',
                  isActive: currentIndex == homeIndex,
                  onTap: () => onTap(homeIndex),
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Articles.png',
                  activeIconFileName: 'ArticlesActive.png',
                  title: 'Articles',
                  isActive: currentIndex == articleIndex,
                  onTap: () => onTap(articleIndex),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Search.png',
                  activeIconFileName: 'SearchActive.png',
                  title: 'Search',
                  isActive: currentIndex == searchIndex,
                  onTap: () => onTap(searchIndex),
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Menu.png',
                  activeIconFileName: 'MenuActive.png',
                  title: 'Menu',
                  isActive: currentIndex == profileIndex,
                  onTap: () => onTap(profileIndex),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xff376AED),
                borderRadius: BorderRadius.circular(32.5),
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Assets.img.icons.plus.image(),
            ),
          )
        ],
      ),
    );
  }
}

class _ButtomNavigationItem extends StatelessWidget {
  final String iconFileName;
  final String activeIconFileName;
  final String title;
  final bool isActive;
  final Function() onTap;

  const _ButtomNavigationItem({
    required this.iconFileName,
    required this.activeIconFileName,
    required this.title,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/icons/${isActive ? activeIconFileName : iconFileName}',
              width: 24,
              height: 24,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: isActive
                  ? themeData.textTheme.bodySmall!.apply(
                      color: themeData.colorScheme.primary,
                    )
                  : themeData.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
