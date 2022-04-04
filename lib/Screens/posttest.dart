import 'dart:convert';

import 'package:carrent/Moudles/AvalibaleCarsMoudle.dart';
import 'package:carrent/Sizeconfig.dart';
import 'package:carrent/service/webservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../HomeScreen.dart';
import '../constans.dart';

class testpage extends StatefulWidget {
  const testpage({Key? key}) : super(key: key);

  @override
  _testpageState createState() => _testpageState();
}

class _testpageState extends State<testpage> {

  late String time;
  late int firstHour;
  late int firstMinute;
  late Future<AvalibaleCarMoudle> futurePost;
  List<String?> carsName = [];
  List<int?> carsPrice = [];
  List<String?> carsImage = [];
  List<String?> carId = [];

  @override
  void initState() {
    super.initState();
    futurePost = postDateAndTime();
    futurePost.then((value) {
      value.data.forEach((key, value) {
        carsName.add(value.name);
        carId.add(key.toString());
        carsPrice.add(value.price);
        carsImage.add(value.image);
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postDateAndTime();
    futurePost;
  }
  Future<AvalibaleCarMoudle> postDateAndTime() async {
    String apiUrl = 'https://lyon-jo.com/api/getAvailableCars.php';

    final json = {
      "startDate": startDate.toString(),
      "startTime": StartTime.toString(),
      "endDate":EndDate.toString(),
      "endTime":EndTime.toString(),
    };

    http.Response response = await http.post(Uri.parse(apiUrl), body: json);
    print(response.body);
    var jsonResponse = jsonDecode(response.body);
    return AvalibaleCarMoudle.fromJson(jsonResponse);

  }


  DateTime? startDate;

  void StartDatePick() {
    showDatePicker(
        context: context,
       
        firstDate:DateTime.now(),
        lastDate: DateTime.now(), initialDate: DateTime.now(),)
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        startDate = value;
      });
    });
  }

  DateTime? EndDate;

  void EndDatePick() {
    showDatePicker(
        context: context,
        initialDate:DateTime.now() ,
        firstDate: DateTime.now(),
        lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        EndDate = value;
      });
    });
  }

  TimeOfDay? StartTime;

  void StartTimePick() {
    showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 12, minute: 0))
        .then((TimeValue) {
      if (TimeValue == null) {
        return;
      }
      setState(() {
        StartTime = TimeValue;
      });
    });
  }

  TimeOfDay? EndTime;

  void EndTimePick() {
    showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 12, minute: 0))
        .then((TimeValue) {
      if (TimeValue == null) {
        return;
      }
      setState(() {
        EndTime = TimeValue;
      });
    });
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding:
          EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DateContainer(
                      StartText: 'Start Date',
                      DateText:
                      '${startDate?.day}-${startDate?.month}-${startDate?.year}',
                      tab: StartDatePick,
                      IfConditon: startDate),
                  DateContainer(
                      StartText: 'End Date Date',
                      DateText:
                      '${EndDate?.day}-${EndDate?.month}-${EndDate?.year}',
                      tab: EndDatePick,
                      IfConditon: EndDate),
                ],
              ),
              //start and end date containers
              SizedBox(
                height: kDefaultPadding,
              ),
              //virtical paading betwen date and time contaniers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TimeContainer(
                      StartText: 'Start Time',
                      DateText: '${StartTime?.hour}:${StartTime?.minute} ',
                      tab: StartTimePick,
                      IfConditon: StartTime),
                  TimeContainer(
                      StartText: 'End Time',
                      DateText: '${EndTime?.hour}:${EndTime?.minute} ',
                      tab: EndTimePick,
                      IfConditon: EndTime),
                ],
              ),
              //atart and end time containers
              SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                  margin:
                  EdgeInsets.only(bottom: getProportionateScreenHeight(15)),
                  height: getProportionateScreenHeight(180),
                  width: getProportionateScreenWidth(200),
                  child: Image.asset(
                    'assets/image/arrow.png',
                    fit: BoxFit.fill,
                    alignment: Alignment.bottomCenter,
                  )),
              //the broken line imaage container
              Container(
                  margin:
                  EdgeInsets.only(bottom: getProportionateScreenHeight(15)),
                  height: getProportionateScreenHeight(30),
                  width: getProportionateScreenWidth(600),
                  child: Text(
                    'Please Fill The Date And Time To Show The Available Cars in That period',
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                  )),
              //the text container
              SizedBox(
                height: kDefaultPadding,
              ),
              ShowCarsContainer(
                  StartText: 'Show Avalibale Cars',
                  DateText: 'Show Avalibale Cars',
                  tab:postDateAndTime,
                  IfConditon: EndTime),

              Container(
                  height: getProportionateScreenHeight(400),
                  width: getProportionateScreenHeight(540),
                  child: FutureBuilder<AvalibaleCarMoudle>(
                          future: futurePost,
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: snapshot.data!.data.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: .85,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    final Cars =snapshot.data!.data[index];

                                    return Center(
                                      child: Container(
                                        height: getProportionateScreenHeight(400),
                                        width: getProportionateScreenWidth(250),
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
                                                child: Image.network(
                                                  carsImage[index].toString(),
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
                                                        carsName[index].toString() ,
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                      Text('L Y O N',style: TextStyle(color: Color(0xff5d69b3),fontSize: 25),),
                                                      Wrap(
                                                        children: <Widget>[
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(carsPrice[index].toString(),  style: TextStyle(
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
                                      ),
                                    );
                                  });

                      }  else {
    throw Exception("${snapshot.data}");
                    }}

                  ))
            ],
          ),
        ),
      ),
    );
  }

  InkWell DateContainer({
    required String StartText,
    required String DateText,
    required VoidCallback tab,
    @required DateTime? IfConditon,
  }) {
    return InkWell(
      onTap: tab,
      child: Container(
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(180),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: IfConditon == null
                ? Text(
              StartText,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
                : Text(DateText,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  InkWell TimeContainer({
    required String StartText,
    required String DateText,
    required VoidCallback tab,
    @required TimeOfDay? IfConditon,
  }) {
    return InkWell(
      onTap: tab,
      child: Container(
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(180),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: IfConditon == null
                ? Text(
              StartText,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
                : Text(DateText,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }

  InkWell ShowCarsContainer(
      {required String StartText,
        required String DateText,
        required VoidCallback tab,
        @required TimeOfDay? IfConditon}) {
    return InkWell(
      onTap: tab,
      child: Container(
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(180),
        decoration: BoxDecoration(
          color: IfConditon != null
              ? kPrimaryColor
              : kPrimaryColor.withOpacity(.6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: IfConditon == null
                ? Text(
              StartText,
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            )
                : Text(DateText,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
    );
  }
}




