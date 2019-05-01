import 'dart:io';
import 'dart:convert';
import '../config/server_config.dart';
import '../util/log.dart';

/// App网络请求类
class SkyHttp {
  static Future<dynamic> get(
      {String path, Map<String, String> queryParameters, String token}) async {
    log("请求路径: $path");
    log("请求参数:$queryParameters");
    log("token: $token");
    var httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri(
      scheme: "https",
      host: host,
      port: port,
      path: path,
      queryParameters: queryParameters,
    ));
    if (token != null && token.isNotEmpty) {
      request.headers.add("token", token);
    }
    try {
      HttpClientResponse response = await request.close();
      if (response.statusCode >= 400) {
        throw '错误码：${response.statusCode}';
      }
      String responseBody = await response.transform(utf8.decoder).join();
      log('响应: $responseBody');
      return json.decode(responseBody);
    } catch (e) {
      log(e);
      throw '请求出错';
    } finally {
      request?.close();
    }
  }
}
