import 'package:flutter/foundation.dart';
import 'package:newsapi/newsapi.dart';

class NewsApiService {
  NewsApiService({@required this.apiKey});
  final String apiKey;

  Future<List<Article>> getArticleResponseByTopHeadLines (String search) async {
      final ArticleResponse response =  await NewsApi(apiKey: apiKey).topHeadlines(
        language: 'es',
        q: search,
      );
      return response.articles;
  }

  Future<List<Article>> getArticleResponseByEverything (String search) async {
    final ArticleResponse response =  await NewsApi(apiKey: apiKey).everything(
      language: 'es',
      pageSize: 30,
      q: search,
    );
    return response.articles;
  }

}