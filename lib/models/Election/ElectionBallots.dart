class ElectionBallot {
  String eid;
  String candidateCnic;
  String voterCnic;

  ElectionBallot({
    this.eid,
    this.candidateCnic,
    this.voterCnic,
  });

  // ElectionBallot.fromJson(Map<String, dynamic> json) {
  //   this.senderId = json['SenderId'];

  //   this.receiverId = json['RecieverId'];

  //   this.bookingId = (json['BookingId']).toInt();
  //   this.text = json['Text'];
  // }
}
