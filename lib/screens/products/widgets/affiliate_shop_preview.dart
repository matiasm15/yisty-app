import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'package:yisty_app/models/affiliate_shop.dart';

class AffiliateShopPreview extends StatelessWidget {
  const AffiliateShopPreview({Key key, this.affiliateShop}) : super(key: key);

  final AffiliateShop affiliateShop;

  Future<void> _launchURL() async {
    if (await canLaunch(affiliateShop.url)) {
      await launch(affiliateShop.url);
    } else {
      throw 'Could not launch ${affiliateShop.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Container(
                child: Image.network(
                    affiliateShop.image,
                    fit: BoxFit.fitHeight
                ),
              ),
              title: Text(affiliateShop.name),
              subtitle: Text(affiliateShop.description),
            ),
            const Divider(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  child: const Text('COMPRAR'),
                  onPressed: _launchURL
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => Share.share('Mira lo que encontre en Yisty: ${affiliateShop.url}')
                )
              ],
            ),
          ]
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      )
    );
  }
}
