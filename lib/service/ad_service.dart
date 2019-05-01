import '../http/sky_http.dart';

class AdService {
  /// 广告获取 type_codes=1000&ent_id=1
  /// 新商城广告 type_code：三种形式字符串 1000 1000,1001,1002 2000-2999
  /// 不传type_code时要传 ad_type_id 一般指某类合集，如热销
  static const _adFetchPath = "/app/ad/fetchAd";

  static Future<dynamic> get(
      {String typeCodes, int adTypeId, int entId}) async {
    var queryParams = <String, String>{"ent_id": entId.toString()};
    if (typeCodes != null && typeCodes.isNotEmpty) {
      queryParams['type_codes'] = typeCodes;
    } else if (adTypeId != null && adTypeId > 0) {
      queryParams['ad_type_id'] = adTypeId.toString();
    } else {
      throw '请求参数有误';
    }
    return await SkyHttp.get(path: _adFetchPath, queryParameters: queryParams);
  }
}
