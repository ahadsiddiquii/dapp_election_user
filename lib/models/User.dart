class AdminCredentials {
  String userId;
  String userCnic;

  AdminCredentials({this.userId, this.userCnic});
  AdminCredentials.fromJson(Map<String, dynamic> json) {
    this.userId = json['userId'];
    print(this.userId);
    this.userCnic = json['userCnic'] ?? '';
    print(this.userCnic);
  }
}
