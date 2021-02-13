import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:yisty_app/services/new_api_service.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/empty_widget.dart';
import 'news_element_show.dart';

@immutable
class HomeShow extends StatefulWidget {
  const HomeShow({Key key}) : super(key: key);

  @override
  _HomeShowState createState() => _HomeShowState();
}

class _HomeShowState extends State<HomeShow> {

  NewsApiService newsApiService = NewsApiService();

  Widget buildLoading() {
    return Center(
        child: Padding(
        padding: const EdgeInsets.all(15.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget> [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                strokeWidth: 6,
                backgroundColor: Colors.white,
              )
            ],
          ),
        )
    );
  }

  Widget buildNoResults() {
    return const EmptyWidget(
        message: 'No se encontraron resultados para tu restricción',
        icon: Icons.search_off_outlined
    );
  }

  Widget buildList(BuildContext context) {
    return FutureBuilder<List<Article>>(
      // cambiar la alberto cuando este las rectricciones
      future: newsApiService.getArticleResponseByEverything('alberto', 'ar', 30, 'es'),
      builder: (_, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
          final List<Article> news = snapshot.data;

          if(news.isEmpty) {
            return buildNoResults();
          }

          return SingleChildScrollView(
            child: _showNews(context, news),
          );
        } else if (snapshot.hasError) {
          if(snapshot.error is AppException) {
            return AlertPage(message: snapshot.error.toString());
          } else {
            throw snapshot.error;
          }
        } else {
          return buildLoading();
        }
      },
    );
  }

  Widget _showNews(BuildContext context, List<Article> news) {
    return Container(
        padding: const EdgeInsets.only(top: 15),
        margin: const EdgeInsets.only(top: 15),
        child: ListView.builder(
            itemCount: news.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return NewsElementShow(
                article: news[index],
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildList(context);
  }

}