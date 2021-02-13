import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapi/newsapi.dart';
import 'package:yisty_app/screens/home/widgets/news_show.dart';

// ignore: must_be_immutable
class NewsElementShow extends StatefulWidget {

  NewsElementShow({@required this.article});
  Article article;

  @override
  _NewElementShowState createState() => _NewElementShowState();
}

class _NewElementShowState extends State<NewsElementShow> {

  @override
  Widget build(BuildContext buildContext) {
    return GestureDetector(
      onTap: () {
        // ignore: always_specify_types
        Navigator.push<MaterialPageRoute>(context,
            // ignore: always_specify_types
            MaterialPageRoute(
                builder: (BuildContext context) => NewsShow(
                  postUrl: widget.article.url,
                )));
      },
      child: Container (
        margin: const EdgeInsets.only(bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: Container (
          child: Container (
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(6))
            ),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.article.urlToImage,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(height: 12),
                Text(
                  widget.article.title,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.article.description,
                  maxLines: 2,
                  style: const TextStyle(
                      color: Colors.black87, fontSize: 14
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}