import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchingType {
  MatchingType({this.icon, this.message, this.color});

  static MatchingType get good {
    return MatchingType(
        icon: 'thumbs-up',
        message: 'APTO',
        color: Colors.green
    );
  }

  static MatchingType get bad {
    return MatchingType(
        icon: 'thumbs-down',
        message: 'NO APTO',
        color: Colors.red
    );
  }

  static MatchingType get unknown {
    return MatchingType(
        icon: 'exclamation-circle',
        message: 'DESCONOCIDO',
        color: Colors.grey
    );
  }

  final String icon;
  final String message;
  final Color color;
}

class Matching extends StatelessWidget {
  const Matching({Key key, this.type, this.size = 24, this.icon = true, this.vertical = false}) : super(key: key);

  final MatchingType type;
  final double size;
  final bool vertical;
  final bool icon;

  Widget _buildSvg(EdgeInsets padding) {
    if (!icon) {
      return Container();
    }

    return Padding(
      padding: padding,
      child: SvgPicture.asset(
        'assets/icons/${type.icon}-solid.svg',
        width: size,
        fit: BoxFit.fitWidth,
        color: type.color
      )
    );
  }

  Widget _buildText() {
    return Text(
      type.message,
      style: TextStyle(color: type.color, fontSize: size * 0.75, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildVertical() {
    return Column(
      children: <Widget>[
        _buildSvg(const EdgeInsets.only(bottom: 7)),
        _buildText()
      ]
    );
  }

  Widget _buildHorizontal() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildSvg(const EdgeInsets.only(right: 7)),
        _buildText()
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    if (vertical) {
      return _buildVertical();
    }

    return _buildHorizontal();
  }
}
