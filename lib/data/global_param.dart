class GlobalParam {
  String countryId;
  String param;

  GlobalParam(this.countryId, this.param);

  GlobalParam.fromJson(Map<String, dynamic> json)
      : countryId = json['countryId'],
        param = json['param'];

  Map<String, dynamic> toJson() => {
        'countryId': countryId,
        'param': param,
      };

  @override
  String toString() {
    return 'GlobalParam{countryId: $countryId, '
        'param: $param, '
        '}';
  }
}
