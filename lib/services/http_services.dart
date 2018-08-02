import 'dart:async';

import 'package:bride_story/models/post_model.dart';
import 'package:bride_story/utils/network_utils.dart';

class HttpServices {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://jsonplaceholder.typicode.com/posts/1";
  static final LOGIN_URL = BASE_URL + "/login.php";
  static final _API_KEY = "somerandomkey";

  Future<Post> login(String username, String password) {
    return _netUtil.post(BASE_URL, body: {
      "token": _API_KEY,
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if (res["error"]) throw new Exception(res["error_msg"]);
      return new Post.map(res["post"]);
    });
  }

  Future<Post> fetchDataJson() async {
    final response =
        await _netUtil.get('https://jsonplaceholder.typicode.com/posts/1');
    // print('agussss');
    // print(response);
    // if (response.statusCode == 200) {
      // print('successs');
      // If the call to the server was successful, parse the JSON
      return Post.map(response);
    // } else {
    //   // If that call was not successful, throw an error.
    //   throw Exception('Failed to load post');
    // }
  }
}
