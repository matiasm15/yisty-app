import 'package:flutter/material.dart';
import 'package:yisty_app/models/affiliate_shop.dart';

import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/screens/products/widgets/affiliate_shops_list.dart';
import 'package:yisty_app/services/rest_client/api_exceptions.dart';
import 'package:yisty_app/widgets/design/alert_page.dart';
import 'package:yisty_app/widgets/design/loading_widget.dart';
import 'package:yisty_app/widgets/inherited_provider.dart';
import 'package:yisty_app/widgets/products/product_information.dart';

class ProductContent extends StatefulWidget {
  const ProductContent({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  Future<List<AffiliateShop>> future;

  @override
  void didChangeDependencies() {
    future ??= InheritedProvider.of(context).services.affiliateShopsProducts.list(<String, String>{
      'product_id': widget.product.id.toString()
    });

    super.didChangeDependencies();
  }

  Widget _buildContent(List<AffiliateShop> affiliateShops) {
    return Column(
        children: <Widget>[
          ProductInformation(product: widget.product),
          AffiliateShopsList(affiliateShops: affiliateShops)
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AffiliateShop>>(
        future: future,
        builder: (_ , AsyncSnapshot<List<AffiliateShop>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.error is AppException) {
              return AlertPage(
                  message: snapshot.error.toString()
              );
            }

            throw snapshot.error;
          }

          if (snapshot.hasData) {
            return _buildContent(snapshot.data);
          }

          return const LoadingWidget();
        }
    );
  }
}