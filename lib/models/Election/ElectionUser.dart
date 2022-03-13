class ElectionUser {
  String eid;
  String userCnic;
  String userPhone;
  String userFullName;
  DateTime dateOfBirth;
  String gender;
  DateTime dateOfCnicExpiry;

  ElectionUser({
    this.eid,
    this.userCnic,
    this.userPhone,
    this.userFullName,
    this.dateOfBirth,
    this.gender,
    this.dateOfCnicExpiry,
  });

  // ElectionUser.fromJson(Map<String, dynamic> json) {
  //   this.senderId = json['SenderId'];

  //   this.receiverId = json['RecieverId'];

  //   this.bookingId = (json['BookingId']).toInt();
  //   this.text = json['Text'];
  // }
}
