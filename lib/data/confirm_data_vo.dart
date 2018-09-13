class ConfirmDataVo {
  String email;
  String image;
  int bookingId;

  ConfirmDataVo(this.email, this.image, this.bookingId);

  ConfirmDataVo.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        image = json['image'],
        bookingId = json['bookingId'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'image': image,
        'bookingId': bookingId,
      };

  @override
  String toString() {
    return 'GlobalParam{email: $email, '
        '}';
  }
}
