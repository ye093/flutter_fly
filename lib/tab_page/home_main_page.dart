import 'package:flutter/cupertino.dart';

import '../icon/icons.dart';
import 'home.dart';
import 'category.dart';
import 'shopping_cart.dart';
import 'mine.dart';
import '../util/log.dart';

/// 底部tab items
const bottomTabItems = <BottomNavigationBarItem> [
  BottomNavigationBarItem(
    icon: Icon(SkyIcons.home_light),
    title: Text('首页'),
  ),
  BottomNavigationBarItem(
    icon: Icon(SkyIcons.apps),
    title: Text('分类'),
  ),
  BottomNavigationBarItem(
    icon: Icon(SkyIcons.cart_light),
    title: Text('购物车'),
  ),
  BottomNavigationBarItem(
    icon: Icon(SkyIcons.my_light),
    title: Text('我的'),
  ),
];


/// 首页main tab页面
class MainTabPage extends StatelessWidget {
  //页面视图缓存
  final _pageCache = new Map<int, Widget>();
  final homePageData = List<String>.generate(100, (int i) => '首页第$i项');

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: bottomTabItems,
        ),
        tabBuilder: (BuildContext context, int index) {
          Widget contentPage = _pageCache.putIfAbsent(index, () {
            log('创建页面$index');
            Widget child;
            switch(index) {
              case 1:
                child = CategoryPage(title: '分类',);
                break;
              case 2:
                child = ShoppingCartPage(title: '购物车',);
                break;
              case 3:
                child = MinePage(title: '我的',);
                break;
              default:
                child = HomePage(title: '首页', data: homePageData);
                break;
            }
            return child;
          });
          return contentPage;
        },
    ); // 首页tab page
  }
}
