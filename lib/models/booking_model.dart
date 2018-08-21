class BookingData {
  // DateTime dateTime;
  int time;
  // 1 day, 2 night
  int idVenue;
  int dateTimeMilisecond;

  BookingData( this.time, this.idVenue, this.dateTimeMilisecond);

  BookingData.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        idVenue = json['idVenue'],
        dateTimeMilisecond = json['dateTimeMilisecond'];

  Map<String, dynamic> toJson() => {        
        'time': time,
        'idVenue': idVenue,
        'dateTimeMilisecond': dateTimeMilisecond,
      };

  @override
  String toString() {
    return 'BookingData{'
        'time: $time, '
        'idVenue: $idVenue, '
        'dateTimeMilisecond: $dateTimeMilisecond, '
        '}';
  }
}
