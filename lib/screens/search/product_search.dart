import 'package:flutter/material.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/services/product_service.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/products/product_list.dart';

class ProductSearch extends SearchDelegate<Product> {
  String selectedResult;
  
  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return Container();
    }

    final ProductService productService = InheritedProvider.of(context).services.products;

    // query!
    return FutureBuilder<List<Product>>(
      future: productService.list(q: query),
      builder: (_ , AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasError) {
          return const ListTile(
              title: Text('No hay resultados para tu búsqueda')
          );
        }

        if (snapshot.hasData) {
          return _showProducts(context, snapshot.data);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showProducts(context, <Product>[]);
  }

  Widget _showProducts(BuildContext context, List<Product> products) {
    return ProductList(
        products: products,
        onTap: (Product product) => close(context, product)
    );
  }
}