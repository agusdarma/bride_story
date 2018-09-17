class SignUpDataVo {
  String _email = '';
  String _password = '';
  int _userType = 0;  

  SignUpDataVo(
      this._email, this._password,this._userType);

  SignUpDataVo.fromJson(Map<String, dynamic> json)
      : _email = json['email'],
      _userType = json['userType'],
        _password = json['password'];

  Map<String, dynamic> toJson() => {
        'email': _email,
        'userType': _userType,
        'password': _password,        
      };

  String get email => _email;
  String get password => _password;
  int get userType => _userType;

  set setEmail(String email) {
    this._email = email;
  }

  set setPassword(String password) {
    this._password = password;
  }

  set setUserType(int userType) {
    this._userType = userType;
  }

  @override
  String toString() {
    return 'SignUpDataVo{email: $_email, '
        'password: $_password, '        
        'userType: $_userType, '        
        '}';
  }
}
