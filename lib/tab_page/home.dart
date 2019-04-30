import 'package:flutter/cupertino.dart';
import 'dart:async';

/// 首页
class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.title, @required this.data})
      : super(key: key);

  final String title;
  final List<String> data;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

//  @override
//  Widget build(BuildContext context) {
//    return CupertinoPageScaffold(
//      child: ListView.builder(
//        itemCount: data.length,
//        itemBuilder: (BuildContext context, int index) {
//          return _HomeItemView(
//            position: index,
//            leading: CupertinoIcons.phone,
//            content: data[index],
//            onClick: () => print('你点击了${data[index]}!'),
//          );
//        },
//      ),
//    );
//  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    final navigationBar = CupertinoNavigationBar(
      middle: Text(widget.title),
    );
    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: CustomScrollView(
        semanticChildCount: 100,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          // 只能用于 phone x
//        CupertinoSliverNavigationBar(
//          largeTitle: Text(widget.title),
//        ),

          // 头不能固定
//          SliverPersistentHeader(
//            delegate: SkyNavigationBar(title: widget.title),
//            pinned: false,
//            floating: false,
//          ),

          // 头不能固定
//          SliverToBoxAdapter(
//            child: CupertinoNavigationBar(
//              middle: Text(widget.title),
//            ),
//          ),

          // 创建一个控件占用 头header和statusBar的高度相当于padding
          SliverPersistentHeader(
            delegate: SkyNavigationBarPadding(paddingTop: paddingTop + navigationBar.preferredSize.height),
            pinned: false,
            floating: true,
          ),

//          SliverPadding(
//            padding: EdgeInsets.only(
//                top: paddingTop + navigationBar.preferredSize.height),
//          ),

          //刷新控件
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future<void>.delayed(Duration(seconds: 2));
            },
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return _HomeItemView(
                    position: index,
                    leading: CupertinoIcons.phone,
                    content: widget.data[index],
                    onClick: () => print('你点击了${widget.data[index]}!'));
              }, childCount: 100),
            ),
          ),
        ],
      ),
    );
  }
}

/// item view
class _HomeItemView extends StatelessWidget {
  _HomeItemView(
      {Key key,
      @required this.position,
      @required this.leading,
      @required this.content,
      @required this.onClick})
      : super(key: key);

  final int position;
  final String content;
  final IconData leading;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: position.isEven
              ? const Color(0xffca8687)
              : const Color(0xfff8aba6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(leading),
            Expanded(child: Center(child: Text(content))),
          ],
        ),
      ),
    );
  }
}

/// 自定义标题头
//class SkyNavigationBar extends SliverPersistentHeaderDelegate {
//  SkyNavigationBar({this.title});
//
//  final String title;
//
//  @override
//  Widget build(
//      BuildContext context, double shrinkOffset, bool overlapsContent) {
//    return CupertinoNavigationBar(
//      middle: Text(title),
//    );
//  }
//
//  @override
//  double get maxExtent => 96.0;
//
//  @override
//  double get minExtent => 44.0;
//
//  @override
//  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//    return false;
//  }
//}

/// 为了占用头部高度
class SkyNavigationBarPadding extends SliverPersistentHeaderDelegate {
  SkyNavigationBarPadding({@required this.paddingTop});

  final double paddingTop;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CupertinoNavigationBar();
  }

  @override
  double get maxExtent => paddingTop;

  @override
  double get minExtent => paddingTop;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
