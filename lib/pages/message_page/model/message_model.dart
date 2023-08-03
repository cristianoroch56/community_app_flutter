class Messagemodel {
  String? message;
  List<ThreadData>? data;

  Messagemodel({this.message, this.data});

  Messagemodel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ThreadData>[];
      json['data'].forEach((v) {
        data!.add(ThreadData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ThreadData {
  int? id;
  int? user1;
  User1Data? user1Data;
  int? user2;
  User1Data? user2Data;
  String? user2Image;
  LastMessage? lastMessage;
  String? updated;
  String? createdAt;

  ThreadData(
      {this.id,
      this.user1,
      this.user1Data,
      this.user2,
      this.user2Data,
      this.user2Image,
      this.lastMessage,
      this.updated,
      this.createdAt});

  ThreadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user1 = json['user1'];
    user1Data = json['user1_data'] != null
        ? User1Data.fromJson(json['user1_data'])
        : null;
    user2 = json['user2'];
    user2Data = json['user2_data'] != null
        ? User1Data.fromJson(json['user2_data'])
        : null;
    user2Image = json['user2_image'];
    lastMessage = json['last_message'] != null
        ? LastMessage.fromJson(json['last_message'])
        : null;
    updated = json['updated'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user1'] = user1;
    if (user1Data != null) {
      data['user1_data'] = user1Data!.toJson();
    }
    data['user2'] = user2;
    if (user2Data != null) {
      data['user2_data'] = user2Data!.toJson();
    }
    data['user2_image'] = user2Image;
    if (lastMessage != null) {
      data['last_message'] = lastMessage!.toJson();
    }
    data['updated'] = updated;
    data['created_at'] = createdAt;
    return data;
  }
}

class User1Data {
  int? id;
  String? username;
  String? firstName;
  String? lastName;

  User1Data({this.id, this.username, this.firstName, this.lastName});

  User1Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class LastMessage {
  int? id;
  String? sender;
  String? message;
  bool? isRead;
  String? image;
  String? createdAt;
  int? thread;

  LastMessage(
      {this.id,
      this.sender,
      this.message,
      this.isRead,
      this.image,
      this.createdAt,
      this.thread});

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    message = json['message'];
    isRead = json['is_read'];
    image = json['image'];
    createdAt = json['created_at'];
    thread = json['thread'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender'] = sender;
    data['message'] = message;
    data['is_read'] = isRead;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['thread'] = thread;
    return data;
  }
}
