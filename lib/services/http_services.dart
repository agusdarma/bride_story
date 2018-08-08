import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/message_vo.dart';
import 'package:bride_story/models/post_model.dart';
import 'package:bride_story/utils/network_utils.dart';

class HttpServices {
  NetworkUtil _netUtil = new NetworkUtil();
  static final baseUrl = "http://192.168.0.101:6556/bride-trx";
  static final categoryUrl = baseUrl + "/cat";
  static final countryUrl = baseUrl + "/country";
  static final cityUrl = baseUrl + "/city";
  static final getAllCarouselImgUrl = baseUrl + "/allCarousel";

  Future<Post> fetchDataPost() async {
    // final response =
    //     await _netUtil.get('https://jsonplaceholder.typicode.com/posts/1');
    final String response =
        await _netUtil.get('http://192.168.0.101/Api/view/test');

    // Post post = new Post.fromJson(response);
    // print(post);
    const JsonDecoder decoder = const JsonDecoder();
    //  print(response);
    Map post = decoder.convert(response);
    Post a = new Post.fromJson(post);
    print(a.title);
    return null;
  }

  Future<List<dynamic>> getCategories() async {
    final String response = await _netUtil.get(categoryUrl);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listCategory = decoder.convert(a.otherMessage);
    return listCategory;
  }

  Future<List<dynamic>> getCountry() async {
    final String response = await _netUtil.get(countryUrl);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listCountry = decoder.convert(a.otherMessage);
    return listCountry;
  }

  Future<List<dynamic>> getCountryWithParam(String param) async {
    // print("getCountryWithParam: ${param}");
    final String response = await _netUtil.post(countryUrl, body: param);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listCountry = decoder.convert(a.otherMessage);
    return listCountry;
  }

  Future<List<dynamic>> getCityWithCountryId(String globalParam) async {
    // print("getCityWithCountryId: ${globalParam}");
    final String response = await _netUtil
        .post(cityUrl, body: globalParam);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listCity = decoder.convert(a.otherMessage);
    return listCity;
  }

  Future<List<dynamic>> getAllCarouselImg() async {
    final String response = await _netUtil.get(getAllCarouselImgUrl);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listCity = decoder.convert(a.otherMessage);
    return listCity;
  }
}
