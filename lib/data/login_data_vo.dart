class LoginDataVo {
  String _email = '';
  String _password = '';
  String _sessionData = '';
  int _sessionDate = 0;
  int _userType = 1;

  LoginDataVo(
      this._email, this._password, this._sessionData, this._sessionDate, this._userType);

  LoginDataVo.fromJson(Map<String, dynamic> json)
      : _email = json['email'],
        _password = json['password'],
        _sessionData = json['sessionData'],
        _sessionDate = json['sessionDate'],
        _userType = json['userType'];

  Map<String, dynamic> toJson() => {
        'email': _email,
        'password': _password,
        'sessionData': _sessionData,
        'sessionDate': _sessionDate,
        'userType': _userType,
      };

  String get email => _email;
  String get password => _password;

  set setUserType(int userType) {
    this._userType = userType;
  }

  set setEmail(String email) {
    this._email = email;
  }

  set setPassword(String password) {
    this._password = password;
  }

  @override
  String toString() {
    return 'LoginData{email: $_email, '
        'password: $_password, '
        'sessionData: $_sessionData'
        'sessionDate: $_sessionDate'
        '}';
  }
}
