class FilterParam {
  String categoryName;
  int categoryId;
  String countryName;
  int countryId;
  String cityName;
  int cityId;
  int bookingDate;
  int idVenue;

  FilterParam(this.categoryName, this.categoryId, this.countryName,
      this.countryId, this.cityName, this.cityId, this.bookingDate);

  FilterParam.fromJson(Map<String, dynamic> json)
      : categoryName = json['categoryName'],
        countryName = json['countryName'],
        categoryId = json['categoryId'],
        countryId = json['countryId'],
        cityName = json['cityName'],
        cityId = json['cityId'],
        idVenue = json['idVenue'],
        bookingDate = json['bookingDate'];

  Map<String, dynamic> toJson() => {
        'categoryName': categoryName,
        'countryName': countryName,
        'categoryId': categoryId,
        'countryId': countryId,
        'cityName': cityName,
        'cityId': cityId,
        'idVenue': idVenue,
        'bookingDate': bookingDate,
      };

  @override
  String toString() {
    return 'FilterParam{categoryName: $categoryName, '
        'countryName: $countryName, '
        'countryId: $countryId, '
        'categoryId: $categoryId, '
        'cityName: $cityName'
        'cityId: $cityId'
        'bookingDate: $bookingDate'
        '}';
  }
}
