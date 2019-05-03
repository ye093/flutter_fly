import 'package:flutter/cupertino.dart';
import 'dart:async';

import '../service/ad_service.dart';
import '../util/log.dart';
import '../entity/ad.dart';

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
}

class _HomePageState extends State<HomePage> {
  // banner页面控制器
  PageController _bannerPageController;

  // 屏幕的大小

  @override
  void initState() {
    super.initState();
    _bannerPageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _bannerPageController?.dispose();
    super.dispose();
  }

  // 广告获取缓存
  Future<AdInfo> _fetchAdByTypeId(int adTypeId) {
    return AdService.get(adTypeId: adTypeId, entId: 1)
        .then((Map<String, dynamic> data) {
      if (data != null && data['code'] == 1) {
        return data['data'] as List<dynamic>;
      }
    }).then((List<dynamic> data) {
      return data[0] as Map<String, dynamic>;
    }).then((data) => AdInfo.fromJson(data));
  }

  /// 获取广告位置信息
  Future<List<AdPosition>> _fetchAdPosition() {
    return AdService.getPosition(typeCodes: '10000-11000', entId: 1)
        .then((Map<String, dynamic> data) {
      if (data != null && data['code'] == 1) {
        return data['data'] as List<dynamic>;
      }
    }).then((List<dynamic> data) {
      return data.map((d) => AdPosition.fromJson(d)).toList();
    });
  }

  /// src: 图片地址
  /// width: 图片宽度
  /// height: 图片高度
  /// route: 点击事件中的跳转目标
  Widget _imageFrom(String src,
      {double width, double height, String route, bool isFill}) {
    return Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.center,
      child: FadeInImage.assetNetwork(
        placeholder: isFill ? 'images/loading_large.png' : 'images/loading.png',
        fit: isFill ? BoxFit.fill : BoxFit.contain,
        image: src,
        width: width,
        height: height,
      ),
    );
  }

  /// 获取广告的大小
  Size _adSize(AdInfo adInfo, Size screenSize) {
    // 宽度计算
    double width = adInfo.width ?? screenSize.width;
    if (width <= 0) width = screenSize.width;
    if (width > 0 && width <= 1) width *= screenSize.width;
    if (width > screenSize.width) width = screenSize.width;
    // 高度计算
    double height = adInfo.height ?? screenSize.height;
    if (height <= 0) height = screenSize.height;
    if (height > 0 && height <= 1) height *= screenSize.height;
    return Size(width, height);
  }

  /// 转化为广告视图
  Widget _toAdTypeWidget(AdInfo adInfo, Size screenSize) {
    if (adInfo == null) {
      return Placeholder();
    }
    // 取广告的关键属性
    final adSize = _adSize(adInfo, screenSize);
    final width = adSize.width;
    final height = adSize.height;

    // 计算列数
    final String pattern = adInfo.pattern ?? '1';
    final List<String> patterns = pattern.split(',');
    // 判断子视图是否需要拉伸,当每列的模式不一致时，则需要拉伸
    final bool isFill = !patterns.every((s) => s == patterns[0]);

    final int cols = adInfo.cols;
    final int rows = adInfo.rows;
    final List<Item> adItems = adInfo.items;
    final maxLen = adItems.length;
    int itemIndex = 0;

    // 总共多少页
    // 计算是否需要多页 PageView
    int pageItems = 0;
    for (int i = 0; i < patterns.length; i++) {
      pageItems += int.parse(patterns[i]) * rows;
    }
    int pageCount = adItems.length ~/ pageItems;
    final pageList = <Widget>[];
    for (int p = 0; p < pageCount; p++) {
      // 总共多少行
      final rowList = <Widget>[];
      for (int i = 0; i < rows; i++) {
        // 创建一行开始
        final rowChildren = <Widget>[];
        for (int r = 0; r < cols; r++) {
          // 看看有几行
          int columns = int.parse(patterns[r]);
          // 每个格子的宽度
          double itemHeight = height / (rows * columns);
          double itemWidth = width / cols;

          if (columns == 1) {
            // 不用创建Column
            Item adItem = adItems[itemIndex++];
            rowChildren.add(_imageFrom(adItem.imgUrl,
                route: adItem.url,
                width: itemWidth,
                height: itemHeight,
                isFill: cols == 1 || isFill));
          } else {
            // 创建column
            final itemColumnsChildren = <Widget>[];
            for (int c = 0; c < columns; c++) {
              Item adItem = adItems[itemIndex++];
              itemColumnsChildren.add(_imageFrom(adItem.imgUrl,
                  route: adItem.url,
                  width: itemWidth,
                  height: itemHeight,
                  isFill: cols == 1 || isFill));
              // 退出循环
              if (itemIndex == maxLen) break;
            }
            final itemColumns = Column(
              children: itemColumnsChildren,
            );
            rowChildren.add(itemColumns);
          }

          // 退出循环
          if (itemIndex == maxLen) break;
        }
        var rowWidget = cols == 1
            ? rowChildren.first
            : Row(
                children: rowChildren,
              );
        // 创建一行结束
        rowList.add(rowWidget);

        // 退出循环
        if (itemIndex == maxLen) break;
      }

      final adTypeView = rows == 1
          ? rowList.first
          : Column(
              children: rowList,
            );
      pageList.add(adTypeView);

      // 退出循环
      if (itemIndex == maxLen) break;
    }

    final adView = pageCount == 1
        ? pageList.first
        : PageView(
            children: pageList,
          );

    return SizedBox(width: width, height: height, child: adView);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final paddingTop = MediaQuery.of(context).padding.top;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    final navigationBar = CupertinoNavigationBar(
      middle: Text(widget.title),
    );
    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: CustomScrollView(
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
            delegate: SkyNavigationBarPadding(
                paddingTop: paddingTop + navigationBar.preferredSize.height),
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
              return _fetchAdPosition();
            },
          ),
          SliverSafeArea(
            top: false,
            sliver: FutureBuilder(
              future: _fetchAdPosition(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AdPosition>> snapshot) {
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                    '加载失败',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  )));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<AdPosition> adPositions = snapshot.data;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      final AdPosition adPosition = adPositions[index];
                      return FutureBuilder<AdInfo>(
                        future: _fetchAdByTypeId(adPosition.adTypeId),
                        builder: (BuildContext context,
                            AsyncSnapshot<AdInfo> adInfoSnap) {
                          if (adInfoSnap.connectionState ==
                              ConnectionState.done) {
                            return _toAdTypeWidget(
                              adInfoSnap.data,
                              screenSize,
                            );
                          } else {
                            return SizedBox(
                              height: adPosition.height ?? 0,
                            );
                          }
                        },
                      );
                    }, childCount: adPositions?.length ?? 0),
                  );
                } else {
                  return SliverToBoxAdapter(
                      child: Container(
                          height: screenSize.height - paddingBottom,
                          width: screenSize.width,
                          alignment: AlignmentDirectional.center,
                          child: const CupertinoActivityIndicator(radius: 20,)));
                }
              },
            ),
          ),
        ],
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
