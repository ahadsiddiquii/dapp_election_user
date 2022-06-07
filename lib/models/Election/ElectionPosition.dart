class ElectionPosition {
  String positionId;
  String eid;
  String positionName;

  ElectionPosition({
    this.positionId,
    this.eid,
    this.positionName,
  });

  ElectionPosition.fromJson(Map<String, dynamic> json) {
    this.positionId = json['positionId'];
    this.eid = json['eid'];
    this.positionName = json['positionName'];
  }

  Map<String, dynamic> toJson(ElectionPosition electionPosition) {
    Map<String, dynamic> electionsMap = {
      "positionId": electionPosition.positionId,
      "eid": electionPosition.eid,
      "positionName": electionPosition.positionName,
    };
    return electionsMap;
  }
}
