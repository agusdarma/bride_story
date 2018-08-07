class FilterParam {
  String categoryName;
  int categoryId;
  String countryName;
  int countryId;
  String cityName;

  FilterParam(this.categoryName,this.categoryId, this.countryName,this.countryId,this.cityName);
    
  FilterParam.fromJson(Map<String, dynamic> json)
    :categoryName = json['categoryName'],
        countryName = json['countryName'],
        categoryId = json['categoryId'],
        countryId = json['countryId'],
        cityName = json['cityName'];

  Map<String, dynamic> toJson() =>
    {
      'categoryName': categoryName,
      'countryName': countryName,
      'categoryId': categoryId,
      'countryId': countryId,
      'cityName': cityName,
    };
  
  @override
  String toString() {
    return 'FilterParam{categoryName: $categoryName, '
        'countryName: $countryName, '
        'countryId: $countryId, '
        'categoryId: $categoryId, '
        'cityName: $cityName'
        '}';
  }
}
