import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:carrent/Sizeconfig.dart';
import 'package:carrent/widget/bottomNavBar.dart';
import 'package:carrent/widget/CarCard.dart';
import 'package:carrent/widget/homeScreenBody.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'avalibalecars.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {


    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: NewAppBar(),
     backgroundColor: Color(0xffE8E8E8),
   
      drawer: Drawer(),

      body:Body(),

    );
  }

  AppBar NewAppBar() {
    return AppBar(

      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(onPressed: (){}, icon:Icon( Icons.menu,color: Color(0xff5d69b3),)),
      actions: [
        IconButton(onPressed: (){}, icon:Icon( FontAwesomeIcons.bell,color:  Color(0xff5d69b3),)),
      ],
    );
  }
}




