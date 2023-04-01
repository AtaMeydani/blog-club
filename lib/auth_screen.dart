import 'package:blog_club/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum _Tab {
  login,
  signup,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  _Tab currentTab = _Tab.signup;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final tabTextStyle = TextStyle(
      color: themeData.colorScheme.onPrimary,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Assets.img.icons.logo.svg(width: 120),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: themeData.colorScheme.primary,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentTab = _Tab.login;
                              });
                            },
                            child: Text(
                              'LOGIN',
                              style: tabTextStyle.apply(
                                color: currentTab == _Tab.login ? Colors.white : Colors.white54,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                currentTab = _Tab.signup;
                              });
                            },
                            child: Text(
                              'SIGN UP',
                              style: tabTextStyle.apply(
                                color: currentTab == _Tab.signup ? Colors.white : Colors.white54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.surface,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child:
                                currentTab == _Tab.login ? _Login(themeData: themeData) : _SignUp(themeData: themeData),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Login extends StatelessWidget {
  const _Login({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Align(
        alignment: Alignment.centerLeft,
        heightFactor: 1.5,
        child: Text(
          'Welcome back',
          style: themeData.textTheme.headlineMedium,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        heightFactor: 1.5,
        child: Text(
          'Sign in with your account',
          style: themeData.textTheme.titleMedium!.apply(fontSizeFactor: .8),
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      const TextField(
        decoration: InputDecoration(
          label: Text('Username'),
        ),
      ),
      const _PasswordTextField(),
      const SizedBox(
        height: 12,
      ),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape:
                MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12)))),
        child: const Text('LOGIN'),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Forgot your password?'),
          const SizedBox(
            width: 8,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Reset here'),
          )
        ],
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'OR SIGN IN WITH',
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      const _OAuth()
    ]);
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp({
    required this.themeData,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Align(
        alignment: Alignment.centerLeft,
        heightFactor: 1.5,
        child: Text(
          'Welcome to blog club',
          style: themeData.textTheme.headlineMedium,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        heightFactor: 1.5,
        child: Text(
          'Please enter your information',
          style: themeData.textTheme.titleMedium!.apply(fontSizeFactor: .8),
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      const TextField(
        decoration: InputDecoration(
          label: Text('Fullname'),
        ),
      ),
      const TextField(
        decoration: InputDecoration(
          label: Text('Username'),
        ),
      ),
      const _PasswordTextField(),
      const SizedBox(
        height: 12,
      ),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
              Size(MediaQuery.of(context).size.width, 60),
            ),
            shape:
                MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12)))),
        child: const Text('SIGNUP'),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'OR SIGN UP WITH',
          style: TextStyle(letterSpacing: 2),
        ),
      ),
      const _OAuth()
    ]);
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        label: const Text('Password'),
        suffix: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Text(
            obscureText ? 'Show' : 'Hide',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _OAuth extends StatelessWidget {
  const _OAuth();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.img.icons.google.image(
          width: 36,
          height: 36,
        ),
        const SizedBox(
          width: 24,
        ),
        Assets.img.icons.facebook.image(
          width: 36,
          height: 36,
        ),
        const SizedBox(
          width: 24,
        ),
        Assets.img.icons.twitter.image(
          width: 36,
          height: 36,
        ),
      ],
    );
  }
}
