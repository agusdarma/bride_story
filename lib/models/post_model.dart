class Post {
  String _title;
  String _body;
  int _id;
  int _userId;
  Post(this._title, this._body, this._id, this._userId);

  Post.map(dynamic obj) {
    this._title = obj["title"];
    this._body = obj["body"];
    this._id = obj["id"];
    this._userId = obj["userId"];
  }

  String get title => _title;
  String get body => _body;
  int get id => _id;
  int get userId => _userId;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = _title;
    map["body"] = _body;
    map["id"] = _id;
    map["userId"] = _userId;

    return map;
  }
}
