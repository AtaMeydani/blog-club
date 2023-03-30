import 'package:blog_club/data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
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
  static const defaultFontFamily = 'Avenir';
  static const primaryTextColor = Color(0xff0D253C);
  static const secondaryTextColor = Color(0xff2D4379);
  static const primaryColor = Color(0xff376AED);
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Club',
      home: Stack(
        children: const [
          Positioned.fill(
            child: HomeScreen(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomNavigation(),
          ),
        ],
      ),
      theme: ThemeData(
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
            fontFamily: defaultFontFamily,
            color: primaryTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w200,
          ),
          titleLarge: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: primaryTextColor,
          ),
          headlineSmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 20,
            color: primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            fontSize: 12,
          ),
          bodySmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: Color(0xff7B8BB2),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final stories = AppDatabase.stories;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Jonathan!',
                      style: themeData.textTheme.titleMedium,
                    ),
                    Image.asset(
                      'assets/img/icons/notification.png',
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 16),
                child: Text(
                  'Explore today’s',
                  style: themeData.textTheme.headlineMedium,
                ),
              ),
              _StoryList(stories: stories, themeData: themeData),
              const SizedBox(
                height: 20,
              ),
              const _CategoryList(),
              const _PostList(),
              const SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  static const categories = AppDatabase.categories;
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: categories.length,
      itemBuilder: (context, index, realIndex) {
        return _CategoryItem(
          left: realIndex == 0 ? 32 : 8,
          right: realIndex == categories.length - 1 ? 32 : 8,
          category: categories[realIndex],
        );
      },
      options: CarouselOptions(
        scrollDirection: Axis.horizontal,
        viewportFraction: 0.8,
        aspectRatio: 1.2,
        initialPage: 0,
        disableCenter: true,
        enableInfiniteScroll: false,
        padEnds: false,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        scrollPhysics: const BouncingScrollPhysics(),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;

  final double left;
  final double right;

  const _CategoryItem({
    required this.category,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            left: 56,
            right: 56,
            top: 100,
            bottom: 16,
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Color(0xff0D253C),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: Colors.black,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xff0D253C),
                    Colors.transparent,
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 48,
            bottom: 48,
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.titleLarge!.apply(
                    color: Colors.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    required this.stories,
    required this.themeData,
  });

  final List<StoryData> stories;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        itemBuilder: (context, index) {
          final story = stories[index];

          return _Story(story: story, themeData: themeData);
        },
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    required this.story,
    required this.themeData,
  });

  final StoryData story;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _profileImageViewed() : _profileImageNormal(),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Text(
              story.name,
              style: themeData.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Container _profileImageNormal() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xff376AED),
          Color(0xff49B0E2),
          Color(0xff9CECFB),
        ]),
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
        ),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImageViewed() {
    return SizedBox(
      width: 68,
      height: 68,
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: const Color(0xff7B8BB2),
        dashPattern: const [8, 3],
        radius: const Radius.circular(24),
        padding: const EdgeInsets.all(7),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.asset(
        'assets/img/stories/${story.imageFileName}',
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  static const posts = AppDatabase.posts;

  const _PostList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest News',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'More',
                  style: TextStyle(
                    color: Color(0xff376AED),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: posts.length,
          itemExtent: 141,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final post = posts[index];
            return _Post(post: post);
          },
        ),
      ],
    );
  }
}

class _Post extends StatelessWidget {
  const _Post({
    required this.post,
  });

  final PostData post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Color(0x1a5282FF),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset('assets/img/posts/small/${post.imageFileName}'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    style: const TextStyle(
                      fontFamily: MainApp.defaultFontFamily,
                      color: MainApp.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    post.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.hand_thumbsup,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        post.likes,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        CupertinoIcons.clock,
                        size: 16,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                      Text(
                        post.time,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            post.isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
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
              child: Image.asset('assets/img/icons/plus.png'),
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
