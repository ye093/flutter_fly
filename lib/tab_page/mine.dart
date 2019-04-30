import 'package:flutter/cupertino.dart';

/// 个人中心，我的页面
class MinePage extends StatelessWidget {

  MinePage({Key key, @required this.title})
      : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Center(child: Text('个人中心啦')),
    );
  }

}