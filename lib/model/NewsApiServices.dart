import 'package:dio/dio.dart';
import 'news_services.dart';

class NewsApiService {
  final Dio _dio = Dio();

  Future<NewsServices?> fetchNews() async {
    final response = await _dio.get('https://newsapi.org/v2/top-headlines', queryParameters: {
      'country': 'in',
      'category': 'business',
      'apiKey': 'f1dafc3fb9bf4bec857ceb8013338b98',  // Replace with your News API key
    });

    if (response.statusCode == 200) {
      return NewsServices.fromJson(response.data);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
