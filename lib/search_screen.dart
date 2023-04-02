import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String tabName;
  final int screenNum;
  const SearchScreen({super.key, required this.tabName, this.screenNum = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tab: $tabName \nScreen: #$screenNum',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  tabName: tabName,
                  screenNum: screenNum + 1,
                ),
              ),
            );
          },
          child: const Text('click me'),
        )
      ],
    );
  }
}
