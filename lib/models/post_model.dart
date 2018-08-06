class Post {
  String _title;
  String _body;
  int _id;
  int _userId;
  Post(this._title, this._body, this._id, this._userId);

  Post.fromJson(Map<dynamic, dynamic> json)
      : _title = json['title'],
        _body = json['body'],
        _id = json['id'],
        _userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'title': _title,
        'body': _body,
        'id': _id,
        'userId': _userId,
      };

  String get title => _title;
  String get body => _body;
  int get id => _id;
  int get userId => _userId;
}
