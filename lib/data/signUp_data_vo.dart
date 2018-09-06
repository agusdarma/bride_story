class SignUpDataVo {
  String _email = '';
  String _password = '';  

  SignUpDataVo(
      this._email, this._password);

  SignUpDataVo.fromJson(Map<String, dynamic> json)
      : _email = json['email'],
        _password = json['password'];

  Map<String, dynamic> toJson() => {
        'email': _email,
        'password': _password,        
      };

  String get email => _email;
  String get password => _password;

  set setEmail(String email) {
    this._email = email;
  }

  set setPassword(String password) {
    this._password = password;
  }

  @override
  String toString() {
    return 'SignUpDataVo{email: $_email, '
        'password: $_password, '        
        '}';
  }
}
