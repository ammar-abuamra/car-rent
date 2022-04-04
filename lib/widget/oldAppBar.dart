import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OldappBar extends StatelessWidget {
  const OldappBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.amber),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            title: Text(
              "L  Y  O  N",
              style: TextStyle(color: Colors.amber, fontSize: 30),
            ),
            elevation: 1.2,
            centerTitle: true,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.opencart,
                    color: Colors.amber,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    color: Colors.amber,
                  ))
            ],
          ),
        )
    );
  }
}
