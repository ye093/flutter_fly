import 'package:flutter/cupertino.dart';

/// 购物车
class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Center(
          child: Text(
        '购物车',
        style: TextStyle(color: CupertinoColors.black),
      )),
    );
  }
}
