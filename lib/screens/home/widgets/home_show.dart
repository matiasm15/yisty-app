import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/empty_widget.dart';
import 'package:yisty_app/screens/home/widgets/news_element_show.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';

@immutable
class HomeShow extends StatefulWidget {
  const HomeShow({Key key}) : super(key: key);

  @override
  _HomeShowState createState() => _HomeShowState();
}

class _HomeShowState extends State<HomeShow> {
  Future<List<Article>> _future;

  Widget buildNoResults() {
    return const EmptyWidget(
        message: 'No se encontraron resultados para tu restricción',
        icon: Icons.search_off_outlined
    );
  }

  @override
  void didChangeDependencies() {
    String preference =InheritedProvider.of(context).uiStore.user.profile.name;
    _future = InheritedProvider.of(context).services.newsApiService.getArticleResponseByEverything(preference);

    super.didChangeDependencies();
  }

  Widget buildList(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: _future,
      builder: (_, AsyncSnapshot<List<Article>> snapshot) {
        if (snapshot.hasData) {
          final List<Article> news = snapshot.data;

          if(news.isEmpty) {
            return buildNoResults();
          }

          return _showNews(context, news);

        } else if (snapshot.hasError) {
          if(snapshot.error is AppException) {
            return AlertPage(message: snapshot.error.toString());
          } else {
            throw snapshot.error;
          }
        }

        return LoadingWidget();
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