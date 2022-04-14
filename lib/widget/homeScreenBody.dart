import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:carrent/Sizeconfig.dart';
import 'package:carrent/widget/CarCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../CarsData.dart';
import '../Screens/avalibalecars.dart';
import '../constans.dart';
import 'HomePageHeader.dart';
import 'OurServiceText.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController controller = ScrollController();
  bool closeServiceList = false;

  @override
  void initState() {

    controller.addListener(() {
      setState(() {
        closeServiceList = controller.offset > 10;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Column(

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomePageHeader(),
              VerticalSpacing(),
              OrServiceText(),
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: closeServiceList?0:1,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  width: getProportionateScreenWidth(600),
                  alignment: Alignment.topCenter,
                  height: closeServiceList?0 : getProportionateScreenHeight(220),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child:FittedBox(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fill,
                      child:  Categoty(),
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Avalibalecars() ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                    height: getProportionateScreenHeight(400),
                    width: getProportionateScreenHeight(600),
                    child:GridView.builder(
                        controller:controller ,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: carsData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: .7,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                        itemBuilder: (context, index) {
                          return cardt(card: carsData[index]);
                        }) ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



Categoty(){
  return Wrap(
    children: List.generate(5, (index){return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),

          height: getProportionateScreenHeight(220),
          width: getProportionateScreenHeight(220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/carsImage/MITSUBISHI_PAJERO.png",
              ),
            ),
          ),
          child: Container(
            height: getProportionateScreenHeight(220),
            width: getProportionateScreenHeight(220),
            decoration: BoxDecoration(
              color: Color(0xff989acd).withOpacity(.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Text("RENTL",
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(60),
                fontWeight: FontWeight.bold,
              )),
        ),
      ],
    );})

  );
}