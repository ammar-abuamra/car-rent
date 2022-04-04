import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:carrent/service/webservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
 CarCard( ScrollController? controller, {Key? key}) : super(key: key);
ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CarsMoudle>>(
      future: GetAllCars().Allcars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<CarsMoudle>cars=snapshot.data!;
          return GridView.builder(
            //controller:controller ,
              shrinkWrap: true,
              physics: ScrollPhysics(),

              itemCount: cars.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return CarCardWidget(cars: cars[index],);
              });

        } else{
          return Text('${snapshot.data}');

        }
      }
      ,
    );
  }
}

class CarCardWidget extends StatelessWidget {
  CarsMoudle cars ;
   CarCardWidget({
    required this.cars,
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
                  child: Image.network(
                    cars.image ,
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
                                  cars.name,
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
                                          Text('Price Per Day',                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black)),
                                          Text(
                                           '\$ '+ cars.price.toString() ,
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


