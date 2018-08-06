class MessageVo {
  String _messageRc;
  String _otherMessage;
  int _rc;

  MessageVo(this._messageRc, this._otherMessage, this._rc);

  MessageVo.fromJson(Map<String, dynamic> json)
      : _messageRc = json['messageRc'],
        _otherMessage = json['otherMessage'],
        _rc = json['rc'];

  Map<String, dynamic> toJson() => {
        'messageRc': _messageRc,
        'otherMessage': _otherMessage,
        'rc': _rc,
      };

  String get messageRc => _messageRc;
  String get otherMessage => _otherMessage;
  int get rc => _rc;

  @override
  String toString() {
    return 'MessageVo{messageRc: $_messageRc, '
        'otherMessage: $_otherMessage, '
        'rc: $_rc'
        '}';
  }
}
