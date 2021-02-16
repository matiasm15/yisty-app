import 'package:flutter/foundation.dart';
import 'package:newsapi/newsapi.dart';

class NewsApiService {
  NewsApiService({@required this.apiKey});
  final String apiKey;
  final NewsApi _newsApi = NewsApi();

  Future<List<Article>> getArticleResponseByTopHeadLines (String search) async {
      _newsApi.init(apiKey: apiKey);
      final ArticleResponse response =  await _newsApi.topHeadlines(
        language: 'es',
        q: search,
      );
      return response.articles;
  }

  Future<List<Article>> getArticleResponseByEverything (String search) async {
    _newsApi.init(apiKey: apiKey);
    final ArticleResponse response =  await _newsApi.everything(
      language: 'es',
      pageSize: 30,
      q: search,
    );
    return response.articles;
  }

}