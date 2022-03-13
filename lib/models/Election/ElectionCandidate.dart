import 'ElectionParty.dart';
import 'ElectionPosition.dart';

class ElectionCandidate {
  String eid;
  String candidateCnic;
  ElectionPosition position;
  ElectionParty party;

  int votes;

  ElectionCandidate({
    this.eid,
    this.candidateCnic,
    this.position,
    this.party,
    this.votes,
  });

  // ElectionCandidate.fromJson(Map< String, dynamic> json) {
  //   this.senderId = json['SenderId'];

  //   this.receiverId = json['RecieverId'];

  //   this.bookingId = (json['BookingId']).toInt();
  //   this.text = json['Text'];
  // }
}
