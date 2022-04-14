import 'package:carrent/CarsData.dart';
import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constans.dart';

class carDetils extends StatelessWidget {
  final String ? carname;

  const carDetils({Key? key, required this.carname}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.list_outlined,
                  color: kPrimaryColor,
                )),
            iconTheme: IconThemeData(color: kPrimaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            title: Text(
              "L  Y  O  N",
              style: TextStyle(color: kPrimaryColor, fontSize: 30),
            ),
            elevation: 1.2,
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.opencart,
                    color: kPrimaryColor,
                  )),
            ],
          ),
        ),
      body: Column(
        children: [
          Container(
            height: 500,width: 500,
            child: Text(carname!),

          )
        ],
      ),
    );
  }
}
