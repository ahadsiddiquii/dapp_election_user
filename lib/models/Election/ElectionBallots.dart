class ElectionBallot {
  String eid;
  String candidateCnic;
  String voterCnic;

  ElectionBallot({
    this.eid,
    this.candidateCnic,
    this.voterCnic,
  });

  ElectionBallot.fromJson(Map<String, dynamic> json) {
    this.eid = json['eid'];
    this.candidateCnic = json['candidateCnic'];
    this.voterCnic = json['voterCnic'];
  }

  Map<String, dynamic> toJson(ElectionBallot electionBallot) {
    Map<String, dynamic> electionsMap = {
      "eid": electionBallot.eid,
      "candidateCnic": electionBallot.candidateCnic,
      "voterCnic": electionBallot.voterCnic,
    };
    return electionsMap;
  }
}
