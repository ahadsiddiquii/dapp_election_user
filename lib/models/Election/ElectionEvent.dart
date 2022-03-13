import 'package:dapp_election_user/models/Election/ElectionBallots.dart';
import 'package:dapp_election_user/models/Election/ElectionCandidate.dart';
import 'package:dapp_election_user/models/Election/ElectionParty.dart';
import 'package:dapp_election_user/models/Election/ElectionPosition.dart';

import 'ElectionUser.dart';

class ElectionEvent {
  String eid;
  String eventName;
  String stateOfEvent;
  DateTime startTime;
  DateTime endTime;
  List<ElectionUser> electionUsers;
  List<ElectionParty> electionParties;
  List<ElectionPosition> electionPositions;
  List<ElectionBallot> electionBallots;
  List<ElectionCandidate> electionCandidates;

  ElectionEvent({
    this.eid,
    this.eventName,
    this.stateOfEvent,
    this.startTime,
    this.endTime,
    this.electionUsers,
    this.electionCandidates,
    this.electionParties,
    this.electionPositions,
    this.electionBallots,
  });

  // ElectionEvent.fromJson(Map<String, dynamic> json) {
  //   this.senderId = json['SenderId'];

  //   this.receiverId = json['RecieverId'];

  //   this.bookingId = (json['BookingId']).toInt();
  //   this.text = json['Text'];
  // }
}
