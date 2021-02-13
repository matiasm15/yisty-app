import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yisty_app/models/product.dart';
import 'package:yisty_app/models/profile.dart';

class ProductMatching extends StatelessWidget {
  const ProductMatching({Key key, this.product, this.profile}) : super(key: key);

  final Product product;
  final Profile profile;

  Widget buildMatchingText(String icon, String message, Color color) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
              'assets/icons/$icon-solid.svg',
              width: 25,
              fit: BoxFit.fitWidth,
              color: color
          ),
          Container(
            child: Text(
              message,
              style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            margin: const EdgeInsets.only(left: 7),
          )
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (profile.isPermitted(product)) {
      return buildMatchingText('thumbs-up', 'APTO', Colors.green);
    } else if (Profile().isDenied(product)) {
      return buildMatchingText('thumbs-down', 'NO APTO', Colors.red);
    } else {
      return buildMatchingText('exclamation-circle', 'DESCONOCIDO', Colors.grey);
    }
  }
}