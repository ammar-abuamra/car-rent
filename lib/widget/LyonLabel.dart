import 'package:flutter/material.dart';

import '../Sizeconfig.dart';
import '../constans.dart';

class lyonLabel extends StatelessWidget {
  const lyonLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(313),
      height: getProportionateScreenHeight(50),
      decoration: BoxDecoration(
          color: Color(0xff5d69b3),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black),
          boxShadow: [BoxShadow(
            offset: Offset(3,3),
            blurRadius: 10,
            color: Colors.white.withOpacity(.05),
            spreadRadius: -2
          )]
      ),
      child: Center(child: Text("L Y O N",style: TextStyle( color: Colors.white, fontSize: getProportionateScreenWidth(30),
        fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)),
    );
  }
}
