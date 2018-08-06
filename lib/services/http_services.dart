import 'dart:async';
import 'dart:convert';

import 'package:bride_story/data/message_vo.dart';
import 'package:bride_story/models/category_model.dart';
import 'package:bride_story/models/post_model.dart';
import 'package:bride_story/utils/network_utils.dart';

class HttpServices {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://jsonplaceholder.typicode.com/posts/1";
  static final LOGIN_URL = BASE_URL + "/login.php";
  static final _API_KEY = "somerandomkey";

  // Future<Post> login(String username, String password) {
  //   return _netUtil.post(BASE_URL, body: {
  //     "token": _API_KEY,
  //     "username": username,
  //     "password": password
  //   }).then((dynamic res) {
  //     print(res.toString());
  //     if (res["error"]) throw new Exception(res["error_msg"]);
  //     return new Post.map(res["post"]);
  //   });
  // }

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
    final String response =
        await _netUtil.get('http://192.168.0.101:6556/bride-trx/cat');

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);  
     
    List<dynamic> listCategory = decoder.convert(a.otherMessage);    
    return listCategory;
  }

  Future<List<dynamic>> getCountry() async {
    final String response =
        await _netUtil.get('http://192.168.0.101:6556/bride-trx/country');

    const JsonDecoder decoder = const JsonDecoder();
    Map messageVO = decoder.convert(response);
    MessageVo a = new MessageVo.fromJson(messageVO);  
     
    List<dynamic> listCountry = decoder.convert(a.otherMessage);    
    return listCountry;
  }
}
