class MessageModel {
  int? count;
  String? next;
  String? previous;
  Results? results;

  MessageModel({this.count, this.next, this.previous, this.results});

  MessageModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results =
        json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class Results {
  String? message;
  List<MessageData>? data;

  Results({this.message, this.data});

  Results.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MessageData>[];
      json['data'].forEach((v) {
        data!.add(MessageData.fromJson(v));
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

class MessageData {
  int? id;
  String? sender;
  String? message;
  bool? isRead;
  String? image;
  String? createdAt;
  int? thread;

  MessageData(
      {this.id,
      this.sender,
      this.message,
      this.isRead,
      this.image,
      this.createdAt,
      this.thread});

  MessageData.fromJson(Map<String, dynamic> json) {
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
