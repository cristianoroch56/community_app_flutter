class Notificationmodel {
  String? next;
  String? previous;
  int? count;
  int? pageSize;
  List<Results>? results;

  Notificationmodel(
      {this.next, this.previous, this.count, this.pageSize, this.results});

  Notificationmodel.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
    count = json['count'];
    pageSize = json['page_size'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next'] = next;
    data['previous'] = previous;
    data['count'] = count;
    data['page_size'] = pageSize;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? title;
  String? content;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? user;

  Results(
      {this.id,
      this.title,
      this.content,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.user});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user'] = user;
    return data;
  }
}
