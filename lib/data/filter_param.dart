class FilterParam {
  String categoryName;
  String countryName;
  int countryId;
  String cityName;

  FilterParam(this.categoryName, this.countryName,this.countryId,this.cityName);
    
  FilterParam.fromJson(Map<String, dynamic> json)
    :categoryName = json['categoryName'],
        countryName = json['countryName'],
        countryId = json['countryId'],
        cityName = json['cityName'];

  Map<String, dynamic> toJson() =>
    {
      'categoryName': categoryName,
      'countryName': countryName,
      'countryId': countryId,
      'cityName': cityName,
    };
  
  @override
  String toString() {
    return 'FilterParam{categoryName: $categoryName, '
        'countryName: $countryName, '
        'countryId: $countryId, '
        'cityName: $cityName'
        '}';
  }
}
