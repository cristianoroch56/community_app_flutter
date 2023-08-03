import 'package:community_app/data/services/api_service.dart';

class NewsRepository {
  final ApiService? apiService;
  NewsRepository({this.apiService});

  getNews({Map<String, dynamic>? param}) async {
    return apiService?.get("api/news/", param: param);
  }

  searchNews(String news) async {
    return apiService?.get("api/news/search_news/?news=$news");
  }

  reportNews(int? id) async {
    return apiService?.patch("api/news/$id/");
  }
}
