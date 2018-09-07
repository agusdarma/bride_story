class BookingParam {
  String email;

  BookingParam(this.email);

  BookingParam.fromJson(Map<String, dynamic> json) : email = json['email'];

  Map<String, dynamic> toJson() => {
        'email': email,
      };

  @override
  String toString() {
    return 'GlobalParam{email: $email, '
        '}';
  }
}
