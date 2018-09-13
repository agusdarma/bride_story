import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/message_vo.dart';
import 'package:bride_story/models/post_model.dart';
import 'package:bride_story/utils/network_utils.dart';

class HttpServices {
  NetworkUtil _netUtil = new NetworkUtil();
  // static final baseUrl = "http://192.168.100.7:6556/bride-trx";
  static final baseUrl = "http://192.168.0.101:6556/bride-trx";
  // static final baseUrl = "http://api.sablonbalon.com:8888/bride-trx";
  static final categoryUrl = baseUrl + "/cat";
  static final countryUrl = baseUrl + "/country";
  static final cityUrl = baseUrl + "/city";
  static final getImageByName = baseUrl + "/getImageByName";
  static final getAllCarouselImgUrl = baseUrl + "/allCarousel";
  static final getAllVenueUrl = baseUrl + "/getListVenue";
  static final getVenueWithIdVenueUrl = baseUrl + "/getVenueById";
  static final createUpdateBookingUrl = baseUrl + "/createUpdateBooking";
  static final getListSimilarVenueUrl = baseUrl + "/getListSimilarVenue";
  static final loginProcessUrl = baseUrl + "/loginProcess";
  static final signUpProcessUrl = baseUrl + "/signUpProcess";
  static final getListMyBookingUrl = baseUrl + "/getListMyBooking";
  static final uploadImagesUrl = baseUrl + "/uploadImages";
  
  
  

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

  Future<dynamic> confirmBooking(String parameter) async {
    final String response = await _netUtil
        .post(uploadImagesUrl, body: parameter);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    // MessageVo a = new MessageVo.fromJson(messageVO);

    // String responseMessage = decoder.convert(a.otherMessage);
    // String responseMessage = messageVO['otherMessage'];
    return messageVO;
  }

  Future<List<dynamic>> getListMyBooking(String parameter) async {
    final String response = await _netUtil
        .post(getListMyBookingUrl, body: parameter);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listMyBooking = decoder.convert(a.otherMessage);
    return listMyBooking;
  }

  Future<dynamic> signUpProcess(String globalParam) async {
    final String response = await _netUtil
        .post(signUpProcessUrl, body: globalParam);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    // MessageVo a = new MessageVo.fromJson(messageVO);

    // String responseMessage = decoder.convert(a.otherMessage);
    // String responseMessage = messageVO['otherMessage'];
    return messageVO;
  }

  Future<dynamic> loginProcess(String globalParam) async {
    final String response = await _netUtil
        .post(loginProcessUrl, body: globalParam);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    // MessageVo a = new MessageVo.fromJson(messageVO);

    // String responseMessage = decoder.convert(a.otherMessage);
    // String responseMessage = messageVO['otherMessage'];
    return messageVO;
  }
  

  Future<dynamic> createUpdateBooking(String globalParam) async {
    final String response = await _netUtil
        .post(createUpdateBookingUrl, body: globalParam);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    // MessageVo a = new MessageVo.fromJson(messageVO);

    // String responseMessage = decoder.convert(a.otherMessage);
    // String responseMessage = messageVO['otherMessage'];
    return messageVO;
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

  Future<List<dynamic>> getAllVenue() async {
    final String response = await _netUtil.get(getAllVenueUrl);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listVenue = decoder.convert(a.otherMessage);
    return listVenue;
  }

  Future<List<dynamic>> getAllVenueWithParam(String parameter) async {
    // final String response = await _netUtil.get(getAllVenueUrl);
    final String response = await _netUtil
        .post(getAllVenueUrl, body: parameter);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listVenue = decoder.convert(a.otherMessage);
    return listVenue;
  }

  Future<List<dynamic>> getVenueWithIdVenue(String parameter) async {
    final String response = await _netUtil
        .post(getVenueWithIdVenueUrl, body: parameter);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listVenue = decoder.convert(a.otherMessage);
    return listVenue;
  }

  Future<List<dynamic>> getListSimilarVenue(String parameter) async {
    final String response = await _netUtil
        .post(getListSimilarVenueUrl, body: parameter);

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);

    List<dynamic> listVenue = decoder.convert(a.otherMessage);
    return listVenue;
  }
  
  
}
