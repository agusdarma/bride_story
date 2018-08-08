import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  // final JsonDecoder _decoder = new JsonDecoder();

  Future<String> get(String url) {
    // print('object res2' + url);
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      // print('object res' + res);
      final int statusCode = response.statusCode;
      // print('statusCode res' + statusCode.toString());
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      // return _decoder.convert(res);
      return res;
    });
  }

  // Future<dynamic> post(String url, {Map headers, body, encoding}) {
  //   return http
  //       .post(url, body: body, headers: headers, encoding: encoding)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;

  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return _decoder.convert(res);
  //   });
  // }

  Future<String> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }
}
