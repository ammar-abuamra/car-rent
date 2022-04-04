import 'package:flutter/material.dart';

import '../Sizeconfig.dart';
import '../constans.dart';

class OrServiceText extends StatelessWidget {
  const OrServiceText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(kDefaultPadding) ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Our Servies",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          IconButton(onPressed: (){}, icon: Icon(Icons.category_outlined,color:  Color(0xff5d69b3),))


        ],

      ),
    );
  }
}
