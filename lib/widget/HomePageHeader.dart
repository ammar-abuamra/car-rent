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
        Image.asset('assets/carsImage/sonata-2015.png',
          height: getProportionateScreenHeight(300),

          fit: BoxFit.contain,),

        Positioned(
          bottom: getProportionateScreenWidth(-25),
          child: lyonLabel(),
        ),
      ],
    );
  }
}
