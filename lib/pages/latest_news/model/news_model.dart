class NewsModel {
  String? next;
  String? previous;
  int? count;
  int? pageSize;
  List<News>? results;

  NewsModel(
      {this.next, this.previous, this.count, this.pageSize, this.results});

  NewsModel.fromJson(Map<String, dynamic> json) {
    next = json['next'];
    previous = json['previous'];
    count = json['count'];
    pageSize = json['page_size'];
    if (json['results'] != null) {
      results = <News>[];
      json['results'].forEach((v) {
        results!.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['count'] = this.count;
    data['page_size'] = this.pageSize;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  int? id;
  String? newsContent;
  String? newsTitle;
  String? image;
  bool? isReported;
  String? createdAt;
  String? updatedAt;

  News(
      {this.id,
      this.newsContent,
      this.newsTitle,
      this.image,
      this.isReported,
      this.createdAt,
      this.updatedAt});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsContent = json['news_content'];
    newsTitle = json['news_title'];
    image = json['image'];
    isReported = json['is_reported'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_content'] = this.newsContent;
    data['news_title'] = this.newsTitle;
    data['image'] = this.image;
    data['is_reported'] = this.isReported;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
