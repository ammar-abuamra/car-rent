
import 'package:carrent/CarsData.dart';
import 'package:carrent/widget/CarCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Sizeconfig.dart';
import '../constans.dart';
import 'CarDetails.dart';

class avalibalecar2 extends StatefulWidget {
  const avalibalecar2({Key? key}) : super(key: key);

  @override
  State<avalibalecar2> createState() => _avalibalecar2State();
}

class _avalibalecar2State extends State<avalibalecar2> {
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
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child:GridView.builder(
             // controller:controller ,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: carsData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .7,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> carDetils(carname:carsData[index].name) ));},
                    child: cardt(card: carsData[index]));
              }) ),
    );
  }
}
