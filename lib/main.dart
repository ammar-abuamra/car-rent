import 'package:carrent/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';

import 'Screens/avalibalecars.dart';
import 'HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode themEmode = ThemeMode.light;
  bool SwitchMode= false ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: themEmode,

      home: BottomNavBar(),
      routes: {
        'navScreen':(context)=>BottomNavBar(),
        'HomePage':(context)=>MyHomePage(),
        'avaliabelCarScreen':(context)=>Avalibalecars(),
      },
    );
  }
}





class CardWidget extends StatelessWidget {

  CardWidget({

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
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: Image.network(
                  'https://th.bing.com/th/id/R.ba48207f235e77ad92cbfc7a9063521d?rik=b6WynMlAIn2zqg&pid=ImgRaw&r=0',
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
                                'The Firset Text',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Wrap(
                                    children: <Widget>[
                                      Column(children: [Text(
                                        'The Second Tex',
                                        style: Theme.of(context).textTheme.subtitle1,
                                      ),

                                        Icon(Icons.share,size: 30,)
                                      ],)


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
