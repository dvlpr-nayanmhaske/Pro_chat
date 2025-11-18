
class UserDetails {
  String? id;
  String? name;
  dynamic profilePicture;
  String? status;

  UserDetails({this.id, this.name, this.profilePicture, this.status});

  UserDetails.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    profilePicture = json["profilePicture"];
    if(json["status"] is String) {
      status = json["status"];
    }
  }

  static List<UserDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["profilePicture"] = profilePicture;
    _data["status"] = status;
    return _data;
  }
}