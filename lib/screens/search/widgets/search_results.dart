import 'package:flutter/material.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/empty_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/products/product_list.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key key, this.query}) : super(key: key);

  final String query;

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  Future<List<Product>> future;

  @override
  void didChangeDependencies() {
    future ??= InheritedProvider.of(context).services.products.list(
      <String, String>{'name[\$iLike]': '%${widget.query}%'}
    );

    super.didChangeDependencies();
  }

  Widget buildNoResults() {
    return const EmptyWidget(
        message: 'No se encontraron resultados para tu búsqueda',
        icon: Icons.search_off_outlined
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: future,
      builder: (_, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error is AppException) {
            return AlertPage(message: snapshot.error.toString());
          } else {
            throw snapshot.error;
          }
        }

        if (snapshot.hasData) {
          final List<Product> products = snapshot.data;

          if (products.isEmpty) {
            return buildNoResults();
          }

          return ProductList(products: snapshot.data);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}