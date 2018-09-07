class BookingData {
  // DateTime dateTime;
  int time;
  // 1 day, 2 night
  int idVenue;
  int dateTimeMilisecond;
  String namaPernikahan;
  String namaPenanggungJawab1;
  String handPhone1;
  String namaPenanggungJawab2;
  String handPhone2;
  String userEmailBooking;

  BookingData(
      this.time,
      this.idVenue,
      this.dateTimeMilisecond,
      this.namaPernikahan,
      this.namaPenanggungJawab1,
      this.handPhone1,
      this.namaPenanggungJawab2,
      this.handPhone2,
      this.userEmailBooking);

  BookingData.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        idVenue = json['idVenue'],
        namaPernikahan = json['namaPernikahan'],
        namaPenanggungJawab1 = json['namaPenanggungJawab1'],
        handPhone1 = json['handPhone1'],
        namaPenanggungJawab2 = json['namaPenanggungJawab2'],
        handPhone2 = json['handPhone2'],
        userEmailBooking = json['userEmailBooking'],
        dateTimeMilisecond = json['dateTimeMilisecond'];

  Map<String, dynamic> toJson() => {
        'time': time,
        'idVenue': idVenue,
        'namaPernikahan': namaPernikahan,
        'namaPenanggungJawab1': namaPenanggungJawab1,
        'handPhone1': handPhone1,
        'namaPenanggungJawab2': namaPenanggungJawab2,
        'handPhone2': handPhone2,
        'userEmailBooking': userEmailBooking,
        'dateTimeMilisecond': dateTimeMilisecond,
      };

  @override
  String toString() {
    return 'BookingData{'
        'time: $time, '
        'idVenue: $idVenue, '
        'namaPernikahan: $namaPernikahan, '
        'namaPenanggungJawab1: $namaPenanggungJawab1, '
        'handPhone1: $handPhone1, '
        'namaPenanggungJawab2: $namaPenanggungJawab2, '
        'handPhone2: $handPhone2, '
        'userEmailBooking: $userEmailBooking, '
        'dateTimeMilisecond: $dateTimeMilisecond, '
        '}';
  }
}
