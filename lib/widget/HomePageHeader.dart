import 'package:flutter/material.dart';

import '../Sizeconfig.dart';
import 'LyonLabel.dart';


class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,

      overflow: Overflow.visible,
      children: [
        Image.network('http:\/\/lyon-jo.com\/wp-content\/uploads\/2019\/05\/sonata-3-2015.png',
          height: getProportionateScreenHeight(300),

          fit: BoxFit.cover,),

        Positioned(
          bottom: getProportionateScreenWidth(-25),
          child: lyonLabel(),
        ),
      ],
    );
  }
}
