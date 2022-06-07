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

  ElectionUser.fromJson(Map<String, dynamic> json) {
    this.eid = json['eid'];
    this.userCnic = json['userCnic'];
    this.userPhone = (json['userPhone']);
    this.userFullName = (json['userFullName']);
    this.dateOfBirth = json['dateOfBirth'] != null
        ? DateTime.parse(json['dateOfBirth'])
        : DateTime.now();
    this.gender = (json['gender']);
    this.userPhone = (json['userPhone']);
    this.dateOfCnicExpiry = json['dateOfCnicExpiry'] != null
        ? DateTime.parse(json['dateOfCnicExpiry'])
        : DateTime.now();
  }
  Map<String, dynamic> toJson(ElectionUser electionUser) {
    Map<String, dynamic> electionsMap = {
      "eid": electionUser.eid,
      "userCnic": electionUser.userCnic,
      "userPhone": electionUser.userPhone,
      "userFullName": electionUser.userFullName,
      "dateOfBirth": electionUser.dateOfBirth.toIso8601String(),
      "gender": electionUser.gender,
      "dateOfCnicExpiry": electionUser.dateOfCnicExpiry.toIso8601String(),
    };
    return electionsMap;
  }
}
