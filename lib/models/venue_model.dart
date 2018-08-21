class VenueModel {
  int id;
  String linkImageVenue;
  String titleVenue;
  String addressVenue;
  String capacityVisitor;
  String capacityParkir;
  String luasBangunan;
  String luasTanah;
  String hargaVenue;
  int idCity;
  String locationVenue;
  int isDay;
  int isNight;
  int isDayFlag;
  int isNightFlag;
  int bookingDate;
  double latitude;
	double longitude;
  List<dynamic> listBookingDate;

  VenueModel(
      this.id,
      this.linkImageVenue,
      this.titleVenue,
      this.addressVenue,
      this.capacityVisitor,
      this.capacityParkir,
      this.luasBangunan,
      this.luasTanah,
      this.hargaVenue,
      this.idCity,
      this.locationVenue,
      this.isDay,
      this.isNight,
      this.isDayFlag,
      this.isNightFlag,
      this.bookingDate,
      this.listBookingDate,
      this.latitude,
      this.longitude);
}
