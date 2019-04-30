import 'package:flutter/cupertino.dart';

/// 分类
class CategoryPage extends StatelessWidget {
  CategoryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        semanticChildCount: 100,
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('大标题!'),
            trailing: Text('trailing...'),
          ),
          SliverPadding(
            padding: MediaQuery.of(context)
                .removePadding(
                    removeTop: true, removeLeft: true, removeRight: true)
                .padding,
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text('分类$index')));
            }, childCount: 100)),
          ),
        ],
      ),
    );
  }
}
