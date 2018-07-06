class FilterParam {
  String categoryName;
  String countryName;
  String cityName;

  FilterParam(this.categoryName, this.countryName,this.cityName);
    
  FilterParam.fromJson(Map<String, dynamic> json)
    :categoryName = json['categoryName'],
        countryName = json['countryName'],
        cityName = json['cityName'];

  Map<String, dynamic> toJson() =>
    {
      'categoryName': categoryName,
      'countryName': countryName,
      'cityName': cityName,
    };
  
  @override
  String toString() {
    return 'FilterParam{categoryName: $categoryName, '
        'countryName: $countryName, '
        'cityName: $cityName'
        '}';
  }
}
