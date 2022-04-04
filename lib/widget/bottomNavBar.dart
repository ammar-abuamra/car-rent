


import 'package:carrent/Screens/avalibalecars.dart';
import 'package:carrent/HomeScreen.dart';
import 'package:carrent/Screens/posttest.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Screens/post2.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {



  int index = 0 ;

  final Screens = [
    MyHomePage(),
    Avalibalecars(),
    testpage(),
    Testq(),
  ];


  @override
  Widget build(BuildContext context) {
    final iteams= <Widget>[
      Icon(
        Icons.home,
        size: 25,
        color:  Color(0xff5d69b3),
      ),
      Icon(Icons.history, size: 25,color:  Color(0xff5d69b3),),
      Icon(Icons.chat, size: 25,color:  Color(0xff5d69b3),),
      Icon(Icons.person, size: 25,color:  Color(0xff5d69b3),),
    ];
    return Scaffold(
      drawer: Drawer(),
      extendBody: true,
      extendBodyBehindAppBar: true,

      //backgroundColor: Color(0xffE8E8E8),
      bottomNavigationBar: CurvedNavigationBar(
        index: index ,
        height: 47,
        animationDuration: Duration(milliseconds: 240),
        buttonBackgroundColor:  Colors.white,

        backgroundColor: Colors.amber.withOpacity(0),
        items: iteams,
        onTap: (index) =>setState(() =>this.index = index),
      ),
      body: Screens[index],


    );
  }
}
