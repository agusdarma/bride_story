class CityParam {
  int countryId;
  String param;

  CityParam(this.countryId, this.param);

  CityParam.fromJson(Map<String, dynamic> json)
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
