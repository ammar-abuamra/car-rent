import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CarsData.dart';
import '../Moudles/CarsMoudle.dart';
import '../Sizeconfig.dart';

class CarCard extends StatelessWidget {
 CarCard( ScrollController? controller, {Key? key}) : super(key: key);
ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: carsData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return cardt(card:  carsData[index],);
        });
  }
}

class CarCardWidget extends StatelessWidget {
  cars car ;
   CarCardWidget({
    required this.car,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:Color(0xff989acd),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: Image.asset(
                    car.image! ,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Color(0xff989acd),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  car.name!,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Wrap(
                                    children: <Widget>[
                                      Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Price Per Day',  style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                          Text(
                                           '\$ '+ car.price.toString() ,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }





}


class cardt extends StatelessWidget {
  cars card;
 cardt({required this.card}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(500),
      width: getProportionateScreenWidth(300),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            offset: const Offset(4, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2,
              child: Image.asset(
                card.image!,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                     card.name! ,
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(24),
                      ),
                    ),
                    Text('L Y O N',style: TextStyle(color: Color(0xff5d69b3),fontSize: 25),),
                    Wrap(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(card.price!.toString(),  style: TextStyle(
                                fontSize: 21,
                                color: Color(0xff5d69b3))),
                            Text('/Day',style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey)),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(50),
                              decoration: BoxDecoration(
                                color: Color(0xff5d69b3),
                                borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                              ),
                              child: Center(
                                child: Icon(Icons.arrow_forward,color: Colors.white,size: 18,),
                              ),
                            )

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
