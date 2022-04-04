import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:carrent/Sizeconfig.dart';
import 'package:carrent/service/webservice.dart';
import 'package:carrent/widget/CarCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

              Container(
                  height: getProportionateScreenHeight(400),
                  width: getProportionateScreenHeight(600),
                  child: FutureBuilder<List<CarsMoudle>>(
                    future: GetAllCars().Allcars(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<CarsMoudle>cars=snapshot.data!;
                        return GridView.builder(
                            controller:controller ,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: cars.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return CarCardWidget(cars: cars[index],);
                            });

                      } else{
                        return Center(child: Column(
                          children: [
                            CircularProgressIndicator(color: Color(0xff5d69b3),),
                            Text('LOADING ... !')
                          ],
                        ));

                      }
                    }
                    ,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

// class CardForsubcatogry extends StatelessWidget {
//   String image;
//   String textforname;
//   int price;
//
//   CardForsubcatogry(
//       {required this.image, required this.textforname, required this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.amber[200],
//             border: Border.all(color: Colors.black),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           height: MediaQuery.of(context).size.height / 6,
//           width: MediaQuery.of(context).size.width,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Image.asset(
//                   image,
//                   height: MediaQuery.of(context).size.height / 5,
//                   width: 150,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Wrap(
//                       children: [
//                         Text(
//                           textforname,
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                     Text(
//                       price.toString() + ' \$',
//                       style: TextStyle(fontSize: 20),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//
// SizedBox(
// child: CarouselSlider(
// options: CarouselOptions(
//
// autoPlay: true,
// ),
// items: [1, 2, 3, 4, 5].map((i) {
// return Builder(
// builder: (BuildContext context) {
// return Container(
// width: MediaQuery.of(context).size.width,
// margin:
// EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
// decoration: BoxDecoration(
//
// borderRadius: BorderRadius.all(Radius.circular(30)),
// color: Colors.amber.withOpacity(.4),
// image: DecorationImage(image: NetworkImage( 'http:\/\/lyon-jo.com\/wp-content\/uploads\/2016\/05\/Kia-Picanto-2016.png',
// )  )
//
// ),
//
// );
// },
// );
// }).toList(),
// ),
// )


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
              image: NetworkImage(
                "http:\/\/lyon-jo.com\/wp-content\/uploads\/2020\/01\/accent-2020-1.png",
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