import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/gen/fonts.gen.dart';
import 'package:blog_club/onboarding_screen.dart';
import 'package:blog_club/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  static const primaryTextColor = Color(0xff0D253C);
  static const secondaryTextColor = Color(0xff2D4379);
  static const primaryColor = Color(0xFF376AED);
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Club',
      // home: Stack(
      //   children: const [
      //     Positioned.fill(
      //       child: HomeScreen(),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       right: 0,
      //       child: _BottomNavigation(),
      //     ),
      //   ],
      // ),
      home: const OnboardingScreen(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: primaryTextColor,
          onBackground: primaryTextColor,
          background: Color(0xFFFBFBFF),
          surface: Colors.white,
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            fontFamily: FontFamily.avenir,
            color: primaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w200,
          ),
          titleLarge: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: primaryTextColor,
          ),
          headlineSmall: TextStyle(
            fontFamily: FontFamily.avenir,
            fontSize: 20,
            color: primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontFamily: FontFamily.avenir,
            color: secondaryTextColor,
            fontSize: 12,
          ),
          bodySmall: TextStyle(
            fontFamily: FontFamily.avenir,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: Color(0xff7B8BB2),
          ),
        ),
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 65,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: const Color(0x009B8487).withOpacity(.3),
              ),
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _ButtomNavigationItem(
                  iconFileName: 'Home.png',
                  activeIconFileName: 'Home.png',
                  title: 'Home',
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Articles.png',
                  activeIconFileName: 'Articles.png',
                  title: 'Articles',
                ),
                SizedBox(
                  width: 8,
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Search.png',
                  activeIconFileName: 'Search.png',
                  title: 'Search',
                ),
                _ButtomNavigationItem(
                  iconFileName: 'Menu.png',
                  activeIconFileName: 'Menu.png',
                  title: 'Menu',
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

  const _ButtomNavigationItem({
    required this.iconFileName,
    required this.activeIconFileName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/img/icons/$iconFileName'),
        const SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
