class ElectionParty {
  String partyCode;
  String eid;
  String partyName;

  ElectionParty({
    this.partyCode,
    this.eid,
    this.partyName,
  });

  ElectionParty.fromJson(Map<String, dynamic> json) {
    this.partyCode = json['partyCode'];
    this.eid = json['eid'];
    this.partyName = json['partyName'];
  }

  Map<String, dynamic> toJson(ElectionParty electionParty) {
    Map<String, dynamic> electionsMap = {
      "partyCode": electionParty.partyCode,
      "eid": electionParty.eid,
      "partyName": electionParty.partyName,
    };
    return electionsMap;
  }
}
