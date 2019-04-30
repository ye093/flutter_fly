import 'package:flutter/cupertino.dart';

import 'tab_page/home_main_page.dart';

void main() => runApp(MyApp());

/// 创建一个ios风格的app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'flutter_sky',
      home: MainTabPage(),
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
              inherit: false,
              fontFamily: 'PuHuiTi',
              fontSize: 17.0,
              letterSpacing: -0.41,
              color: CupertinoColors.black,
              decoration: TextDecoration.none,
            ),
            actionTextStyle: TextStyle(
              inherit: false,
              fontFamily: 'PuHuiTi',
              fontSize: 17.0,
              letterSpacing: -0.41,
              color: CupertinoColors.activeBlue,
              decoration: TextDecoration.none,
            ),
          tabLabelTextStyle: TextStyle(
            inherit: false,
            fontFamily: 'PuHuiTi',
            fontSize: 10.0,
            letterSpacing: -0.24,
            color: CupertinoColors.inactiveGray,
          ),
          navLargeTitleTextStyle: TextStyle(
            inherit: false,
            fontFamily: 'PuHuiTi',
            fontSize: 34.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.41,
            color: CupertinoColors.black,
          ),
          navTitleTextStyle: TextStyle(
            inherit: false,
            fontFamily: 'PuHuiTi',
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
            color: CupertinoColors.black,
          ),
          navActionTextStyle: TextStyle(
            inherit: false,
            fontFamily: 'PuHuiTi',
            fontSize: 17.0,
            letterSpacing: -0.41,
            color: CupertinoColors.activeBlue,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
