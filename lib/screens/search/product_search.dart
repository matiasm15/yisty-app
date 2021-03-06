import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/screens/search/widgets/search_results.dart';
import 'package:yisty_app/widgets/design/empty_widget.dart';
import 'package:yisty_app/widgets/products/product_list.dart';

class ProductSearch extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isEmpty) {
      return <Widget>[];
    }

    return <Widget>[
      IconButton(icon: const Icon(Icons.close), onPressed: () {
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ThemeData(
      primaryColor: theme.primaryColor,
      primaryIconTheme: IconThemeData(
        color: theme.secondaryHeaderColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.secondaryHeaderColor)
      ),
      textTheme: TextTheme(headline6: TextStyle(color: theme.secondaryHeaderColor))
    );
  }

  Widget buildNoSearch() {
    return const EmptyWidget(
      message: 'Escribe algo para empezar a buscar',
      icon: Icons.search
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return buildNoSearch();
    }

    return SearchResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.trim().isEmpty) {
      return buildNoSearch();
    }

    return _showProducts(context, <Product>[]);
  }

  Widget _showProducts(BuildContext context, List<Product> products) {
    return ProductList(
        products: products
    );
  }
}
