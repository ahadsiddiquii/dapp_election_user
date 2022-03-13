class ElectionPosition {
  String positionId;
  String eid;
  String positionName;

  ElectionPosition({
    this.positionId,
    this.eid,
    this.positionName,
  });

  // ElectionPosition.fromJson(Map<String, dynamic> json) {
  //   this.senderId = json['SenderId'];

  //   this.receiverId = json['RecieverId'];

  //   this.bookingId = (json['BookingId']).toInt();
  //   this.text = json['Text'];
  // }
}
