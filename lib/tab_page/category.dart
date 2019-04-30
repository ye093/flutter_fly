import 'package:flutter/cupertino.dart';

/// 分类
class CategoryPage extends StatelessWidget {
  CategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Center(
        child: Text(
          'HelloWolrd',
          style: CupertinoTheme.of(context)
              .textTheme
              .textStyle
              .copyWith(color: Color(0xffff0000)),
        ),
      ),
    );
  }
}
