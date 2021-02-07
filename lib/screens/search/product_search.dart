import 'package:flutter/material.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/services/product_service.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/empty_page.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
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
    return const EmptyPage(
      message: 'Escribe algo para empezar a buscar',
      icon: Icons.search
    );
  }

  Widget buildNoResults() {
    return const EmptyPage(
        message: 'No se encontraron resultados para tu búsqueda',
        icon: Icons.search_off_outlined
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return buildNoSearch();
    }

    final InheritedProvider provider = InheritedProvider.of(context);
    final ProductService productService = provider.services.products;

    return FutureBuilder<List<Product>>(
      future: productService.list(<String, String>{'name[\$iLike]': '%$query%'}),
      builder: (_ , AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError) {
          if (snapshot.error is AppException) {
            return AlertPage(
                message: snapshot.error.toString()
            );
          } else {
            throw snapshot.error;
          }
        }

        if (snapshot.hasData) {
          final List<Product> products = snapshot.data;

          if (products.isEmpty) {
            return buildNoResults();
          }

          return _showProducts(context, products);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
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
        products: products,
        onTap: (Product product) => close(context, product)
    );
  }
}
