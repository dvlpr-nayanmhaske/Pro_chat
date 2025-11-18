
class Conversation {
  String? id;
  String? name;
  dynamic profilePicture;
  LastMessage? lastMessage;
  String? updatedAt;
  int? unseenMessageCount;

  Conversation({this.id, this.name, this.profilePicture, this.lastMessage, this.updatedAt, this.unseenMessageCount});

  Conversation.fromJson(Map<String, dynamic> json) {
    if(json["id"] is String) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    profilePicture = json["profilePicture"];
    if(json["lastMessage"] is Map) {
      lastMessage = json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]);
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["unseenMessageCount"] is int) {
      unseenMessageCount = json["unseenMessageCount"];
    }
  }

  static List<Conversation> fromList(List<Map<String, dynamic>> list) {
    return list.map(Conversation.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["profilePicture"] = profilePicture;
    if(lastMessage != null) {
      _data["lastMessage"] = lastMessage?.toJson();
    }
    _data["updatedAt"] = updatedAt;
    _data["unseenMessageCount"] = unseenMessageCount;
    return _data;
  }
}

class LastMessage {
  String? text;
  dynamic image;
  String? sender;
  String? createdAt;

  LastMessage({this.text, this.image, this.sender, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    if(json["text"] is String) {
      text = json["text"];
    }
    image = json["image"];
    if(json["sender"] is String) {
      sender = json["sender"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
  }

  static List<LastMessage> fromList(List<Map<String, dynamic>> list) {
    return list.map(LastMessage.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["text"] = text;
    _data["image"] = image;
    _data["sender"] = sender;
    _data["createdAt"] = createdAt;
    return _data;
  }
}