/// 广告配置信息
class AdInfo {
  /// 广告的宽度，0或者null为不限制
  final double width;

  /// 广告的高度，0或者null为不限制
  final double height;

  /// 模式
  final String pattern;

  /// 行数
  final int rows;

  /// 列数
  final int cols;

  /// 广告类型id
  final int adTypeId;

  /// 广告内容
  final List<Item> items;

  AdInfo(
      {this.width,
      this.height,
      this.pattern,
      this.rows,
      this.cols,
      this.items,
      this.adTypeId});

  AdInfo.fromJson(Map<String, dynamic> json)
      : width = json['width'],
        height = json['height'],
        pattern = json['pattern'],
        rows = json['rows'],
        cols = json['cols'],
        adTypeId = json['ad_type_id'],
        items = new List<Item>() {
    List<dynamic> adItems = json['items'];
    if (adItems != null && adItems.isNotEmpty) {
      for (Map<String, dynamic> item in adItems) {
        items.add(Item(
            adLineId: item['ad_line_id'],
            imgUrl: item['img_url'],
            url: item['url']));
      }
    }
  }
}

/// 广告信息最小单位
class Item {
  int adLineId;
  String imgUrl;
  String url;

  Item({this.adLineId, this.imgUrl, this.url});
}

/// 广告位置信息
class AdPosition {
  //t.ad_type_id,t.type_code,t.rows,t.cols,t.width,t.height,t.pattern
  int adTypeId;
  int typeCode;
  int rows;
  int cols;
  double width;
  double height;
  String pattern;

  AdPosition({this.adTypeId, this.typeCode, this.rows, this.cols, this.width, this.height, this.pattern});


  AdPosition.fromJson(Map<String, dynamic> json)
      : adTypeId = json['ad_type_id'],
        typeCode = json['type_code'],
        rows = json['rows'],
        cols = json['cols'],
        width = json['width'],
        height = json['height'],
        pattern = json['pattern'];
}
