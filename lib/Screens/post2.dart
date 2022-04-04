import 'dart:convert';

import 'package:carrent/Moudles/AvalibaleCarsMoudle.dart';
import 'package:carrent/Sizeconfig.dart';
import 'package:carrent/service/webservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../HomeScreen.dart';
import '../constans.dart';

class Testq extends StatefulWidget {
  const Testq({Key? key}) : super(key: key);

  @override
  _TestqState createState() => _TestqState();
}

class _TestqState extends State<Testq> {



   Future<AvalibaleCarMoudle>? futurePost;
  List<String?> carsName = [];
  List<int?> carsPrice = [];
  List<String?> carsImage = [];
  List<String?> carId = [];


  Future<AvalibaleCarMoudle> postDateAndTime() async {
    String apiUrl = 'https://lyon-jo.com/api/getAvailableCars.php';

    final json = {
      "startDate": firstDate.toString(),
      "startTime": time.toString(),
      "endDate":lastDate.toString(),
      "endTime":time.toString(),
    };

    http.Response response = await http.post(Uri.parse(apiUrl), body: json);
    print(response.body);
    var jsonResponse = jsonDecode(response.body);
    return AvalibaleCarMoudle.fromJson(jsonResponse);

  }


  TextEditingController firstDateController = TextEditingController();
  TextEditingController firstTimeController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  DateTime? selectedDate;
  DateTime? firstDate;
  DateTime? lastDate;
  DateTime? firstController;
  DateTime? secondController;
  ValueNotifier<DateTime> _dateTimeNotifier =
  ValueNotifier<DateTime>(DateTime.now());
  int? difference;
  int? differenceHours;
  bool isDateNull =true;

  Future<void> _selectDateFirst(
      {required BuildContext context,
        required TextEditingController dateController,
        selectedDate,
        firstDate,
        lastDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        // initialFirstDate: new DateTime.now(),
        // initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: firstDate,
        lastDate: DateTime((DateTime.now().year) + 3, 12),
        errorInvalidText: "Out of range");
    if (firstDateController.text == null) {
      return null;
    }
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        firstController = picked;

        dateController.text =
        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      });
  }

  Future<void> _selectDateSecond(
      {required BuildContext context,
        required TextEditingController dateController,
        selectedDate,
        firstDate,
        lastDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        currentDate: selectedDate,
        // initialDatePickerMode: selectedDate,
        lastDate: selectedDate.add(Duration(days: 35)),
        errorInvalidText: "Out of range");
    if (picked != null)
      setState(() {
        selectedDate = picked;
        secondController = selectedDate;
        dateController.text =
        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
      });
  }

   String ?time;

  Future<void> _selectTimeFirst(
      {required BuildContext context,
        required TextEditingController timeController}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (pickedTime != null) {
      time = pickedTime.format(context);
      DateTime parsedTime =
      DateFormat.Hm().parse(pickedTime.format(context).toString());
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      setState(() {
        timeController.text = pickedTime.format(context);
        // firstHour = pickedTime.hour;
        // firstMinute = pickedTime.minute;
      });
    }
  }

  Future<void> _selectTimeSecond(
      {required BuildContext context,
        required TextEditingController timeController}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      time = pickedTime.format(context);
      DateTime parsedTime =
      DateFormat.Hm().parse(pickedTime.format(context).toString());
      String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
      setState(() {
        timeController.text = pickedTime.format(context);

        // secondHour = pickedTime.hour;
        // secondMinute = pickedTime.minute;
      });
    }
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildPreferredSize(),
      body:carsName.isEmpty? Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
            EdgeInsets.symmetric(vertical: getProportionateScreenHeight(50)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
              Container(color: Colors.amber,
                height: getProportionateScreenHeight(80),
                width: getProportionateScreenWidth(180),
                child: textFieldWidgetWithoutFilledWithFunctionSmall(
                context: context,
                fun: () {
                  _selectDateFirst(
                    context: context,
                    dateController:
                    firstDateController,
                    selectedDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                        (DateTime.now().year) + 3,
                        12),
                  );
                  setState(() {
                    isDateNull = false;
                  });
                },
                icons: Icon(Icons.calendar_today),
                controller: firstDateController,
                hintText: "start_date",
                textValidatorEmpty:
                "please_enter_start_date",
            ),
              ),
            Container(
              color:  Colors.amber,
              height: getProportionateScreenHeight(80),
              width: getProportionateScreenWidth(180),
              child: textFieldWidgetWithoutFilledWithFunctionSmall(
                context: context,
                fun: () {
                  _selectTimeFirst(
                      context: context,
                      timeController:
                      firstTimeController);
                },
                icons: Icon(Icons.access_time),
                controller: firstTimeController,
                hintText: "start_time",
                textValidatorEmpty:
                "please_enter_start_time",
              ),
            ),

          SizedBox(
            width: 10,
          ),
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
                    Container(
                      color:  Colors.amber,
                      height: getProportionateScreenHeight(80),
                      width: getProportionateScreenWidth(180),
                      child: textFieldWidgetWithoutFilledWithFunctionSmall(
                        context: context,
                        fun:isDateNull?(){}: () {
                          _selectDateSecond(
                            context: context,
                            dateController:
                            endDateController,
                            firstDate: DateTime.now(),
                            selectedDate: firstController,
                            lastDate:firstController!.add(Duration(days: 35)),
                          );
                        },
                        icons: Icon(Icons.calendar_today),
                        controller: endDateController,
                        hintText: "end_date",
                        textValidatorEmpty:
                        "please_enter_end_date",
                      ),
                    ),
                    Container(
                      color:  Colors.amber,
                      height: getProportionateScreenHeight(80),
                      width: getProportionateScreenWidth(180),
                      child: textFieldWidgetWithoutFilledWithFunctionSmall(
                        context: context,
                        fun: () {
                          _selectTimeSecond(
                              context: context,
                              timeController:
                              endTimeController);
                        },
                        icons: Icon(Icons.access_time),
                        controller: endTimeController,
                        hintText: "end_time",
                        textValidatorEmpty:
                        "please_enter_end_time",
                      ),
                    )


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
                Container(


                ),
                ShowCarsContainer(
                    StartText: 'Show Avalibale Cars',
                    DateText: 'Show Avalibale Cars',
                    tab:endDateController==null && firstDateController ==null && endTimeController==null  ? (){}:() {
                      setState(() {
                        futurePost = postDateAndTime();
                        futurePost?.then((value) {
                          value.data.forEach((key, value) {
                            carsName.add(value.name);
                            carId.add(key.toString());
                            carsPrice.add(value.price);
                            carsImage.add(value.image);
                          });


                        });
                      });
                      firstDate:
                      firstDateController.text;
                      firstTime:
                      firstTimeController.text;
                      endDate:
                      endDateController.text;
                      endTime:
                      endTimeController.text;


                    },

                    IfConditon: lastDate),

              ],
            ),
          ),
        ),
      ):                Container(
          // height: getProportionateScreenHeight(400),
          // width: getProportionateScreenHeight(540),
          child: FutureBuilder<AvalibaleCarMoudle>(
              future: futurePost,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  return   GridView.builder(
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          height: 60,width: 60,
                          child: CircularProgressIndicator(
                            backgroundColor: SecondryColor,
                            valueColor: AlwaysStoppedAnimation<Color>(PrimaryColor),

                            strokeWidth: 5,
                          ),
                        ),

                        Text("Indicator",style: TextStyle(color: PrimaryColor,fontWeight: FontWeight.w800),)
                      ],
                    ),
                  );
                  throw Exception("${snapshot.data}");
                }}

          ))
      ,
    );
  }

  PreferredSize buildPreferredSize() {
    return PreferredSize(
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

  InkWell ShowCarsContainer(
      {required String StartText,
        required String DateText,
        required VoidCallback tab,
        @required DateTime? IfConditon}) {
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




Widget textFieldWidgetWithoutFilledWithFunctionSmall(
    {required BuildContext context,
      required String hintText,
      required Widget icons,
      required Function fun,
      bool checkLength = false,
      bool checkEmail = false,
      String textValidatorEmail = "Please Enter Correct Email",
      String textValidatorEmpty = "",
      String textValidatorLength = "",
      required TextEditingController controller}) {
  return ConstrainedBox(
    constraints: BoxConstraints(minWidth: double.infinity, minHeight: 50 ),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return textValidatorEmpty;
        } else {
          return null;
        }
      },
      onTap: () => fun(),
      controller: controller,
      showCursor: true,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: 16.0,color: Colors.black),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: icons,
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 15,color: Colors.black),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.amber, width: 1.0)),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}