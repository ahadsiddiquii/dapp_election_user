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

  ElectionCandidate.fromJson(Map<String, dynamic> json) {
    this.eid = json['eid'];
    this.candidateCnic = json['candidateCnic'];
    this.position = ElectionPosition.fromJson(json['position']);
    this.party = ElectionParty.fromJson(json["party"]);

    this.votes = json['votes'];
  }

  Map<String, dynamic> toJson(ElectionCandidate electionCandidate) {
    Map<String, dynamic> electionsMap = {
      "eid": electionCandidate.eid,
      "candidateCnic": electionCandidate.candidateCnic,
      "votes": electionCandidate.votes,
      "party": electionCandidate.party.toJson(electionCandidate.party),
      "position": electionCandidate.position.toJson(electionCandidate.position),
    };
    return electionsMap;
  }
}
