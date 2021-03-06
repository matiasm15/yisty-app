import 'package:flutter/material.dart';

import 'package:yisty_app/models/affiliate_shop.dart';
import 'package:yisty_app/screens/products/widgets/affiliate_shop_preview.dart';
import 'package:yisty_app/widgets/design/subtitle.dart';

class AffiliateShopsList extends StatelessWidget {
  const AffiliateShopsList({Key key, this.affiliateShops}) : super(key: key);

  final List<AffiliateShop> affiliateShops;

  Widget buildList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: affiliateShops.length,
        itemBuilder: (BuildContext context, int i) {
          return AffiliateShopPreview(
              affiliateShop: affiliateShops.elementAt(i)
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (affiliateShops.isEmpty) {
      return Container();
    }

    return Container(
      child: Column(
        children: <Widget>[
          Subtitle(
            text: 'Podés encontrar este producto en:',
            type: SubtitleType.h2,
          ),
          buildList()
        ]
      ),
      margin: const EdgeInsets.only(bottom: 10)
    );
  }
}