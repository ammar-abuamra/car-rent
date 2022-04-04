import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:lyon/api/api.dart';
import 'package:lyon/api/methodApi.dart';
import 'package:lyon/const/SizeConfig.dart';
import 'package:lyon/model/cars.dart';
import 'package:lyon/screen/available_car.dart';
import 'package:lyon/shared/Widgets/TextFieldWidget.dart';
import 'package:lyon/shared/Widgets/button.dart';
import 'package:lyon/shared/mehod/switch_sreen.dart';
import 'package:lyon/shared/styles/colors.dart';

import 'Translate/Localization.dart';
import 'details_car.dart';

class Rental extends StatefulWidget {
  const Rental({Key? key}) : super(key: key);

  @override
  _RentalState createState() => _RentalState();
}

class _RentalState extends State<Rental> {
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

  late String time;

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

  List<Cars> listCar = [];
  bool openLoading = true;
  List<String> carsName = [];
  List<int> carsPrice = [];
  List<String> carsImage = [];
  List<int> carsId = [];

  Future getCarFromApi() async {

    await MethodAppApi().methodGet(url: ApiApp.getCar).then((value) {
      int length = value['count'];
      for (int i = 0; i < length; i++) {
        carsId.add(value['data'][i]['id']);
        carsName.add(value['data'][i]['name']);

        carsPrice.add(value['data'][i]['price']);
        carsImage.add(value['data'][i]['image']);
      }

    });

  }

  @override
  void initState() {

    getCarFromApi().then((value) {
      if (mounted) {
        setState(() {

          openLoading = false;
        });
      }
    });
    super.initState();

  }


  final _formKey = GlobalKey<FormState>();

  DateTime now = DateTime.now();
  // DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding:  EdgeInsets.only(left: 8, right: 8,bottom: MediaQuery.of(context).size.height*.08),
          child: NestedScrollView(
            body: openLoading
                ? Center(child: CircularProgressIndicator())
                :_gridView(context, orientation),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height * .3,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Positioned.fill(
                            child: Container(
                              color: Colors.transparent,
                            )),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "car available".tr,
                                style: TextStyle(
                                    color: secondaryColor1,
                                    fontSize: MediaQuery.of(context)
                                        .size
                                        .width *
                                        .05,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .005,
                              ),
                              // Text(
                              //   "Choose your period time car",
                              //   style: TextStyle(
                              //     color: Colors.grey,
                              //     fontSize:
                              //         MediaQuery.of(context).size.width *
                              //             .05,
                              //   ),
                              // ),
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .01,
                              ),
                              //             Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              // Expanded(
                              //     flex: 4,
                              //     child:
                              //         textFieldWidgetWithoutFilledWithFunctionSmall(
                              //       context: context,
                              //       fun: () {
                              //         _selectDateFirst(
                              //           context: context,
                              //           dateController: firstDate,
                              //           selectedDate: DateTime.now(),
                              //           firstDate: DateTime.now(),
                              //           lastDate:
                              //               DateTime((DateTime.now().year) + 3, 12),
                              //         );
                              //       },
                              //       icons: const Icon(Icons.calendar_today),
                              //       controller: firstDate,
                              //       hintText: "From",
                              //       textValidatorEmpty: "Enter This Field",
                              //     ),
                              // ),
                              // SizedBox(
                              //     width: MediaQuery.of(context).size.width * .03,
                              // ),
                              // Expanded(
                              //     flex: 4,
                              //     child:
                              //         textFieldWidgetWithoutFilledWithFunctionSmall(
                              //       context: context,
                              //       fun: () {
                              //         _selectDateSecond(
                              //           context: context,
                              //           dateController: secondDate,
                              //           firstDate: DateTime.now(),
                              //           selectedDate: secondDate,
                              //           lastDate:
                              //               DateTime((DateTime.now().year) + 3, 12),
                              //         );
                              //       },
                              //       icons: const Icon(Icons.calendar_today),
                              //       controller: secondDate,
                              //       hintText: "To",
                              //       textValidatorEmpty: "Enter This Field",
                              //     ),
                              // ),
                              //               ],
                              //             ),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child:
                                    textFieldWidgetWithoutFilledWithFunctionSmall(
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
                                      hintText: "start_date".tr,
                                      textValidatorEmpty:
                                      "please_enter_start_date".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child:
                                    textFieldWidgetWithoutFilledWithFunctionSmall(
                                      context: context,
                                      fun: () {
                                        _selectTimeFirst(
                                            context: context,
                                            timeController:
                                            firstTimeController);
                                      },
                                      icons: Icon(Icons.access_time),
                                      controller: firstTimeController,
                                      hintText: "start_time".tr,
                                      textValidatorEmpty:
                                      "please_enter_start_time".tr,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child:
                                    textFieldWidgetWithoutFilledWithFunctionSmall(
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
                                      hintText: "end_date".tr,
                                      textValidatorEmpty:
                                      "please_enter_end_date".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child:
                                    textFieldWidgetWithoutFilledWithFunctionSmall(
                                      context: context,
                                      fun: () {
                                        _selectTimeSecond(
                                            context: context,
                                            timeController:
                                            endTimeController);
                                      },
                                      icons: Icon(Icons.access_time),
                                      controller: endTimeController,
                                      hintText: "end_time".tr,
                                      textValidatorEmpty:
                                      "please_enter_end_time".tr,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    push(
                                        context,
                                        AvailableCars(
                                          firstDate:
                                          firstDateController.text,
                                          firstTime:
                                          firstTimeController.text,
                                          endDate:
                                          endDateController.text,
                                          endTime:
                                          endTimeController.text,
                                          // firstYear : firstController!.year,
                                          // secondYear:secondController!.year,
                                          //   firstDay : firstController!.day,
                                          // secondDay:secondController!.day,
                                          //   firstMonth : firstController!.month,
                                          // secondMonth:secondController!.month,
                                          // firstHour:firstHour,
                                          // secondHour:secondHour,
                                        ));
                                  }
                                },
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height *
                                      .07,
                                  decoration: const BoxDecoration(
                                      color: secondaryColor1,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                      child: Text(
                                        "search".tr,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .05),
                                      )),
                                ),
                              ),
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height *
                              //           .005,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
          ),
        ),
      ),
    );
  }

  SizedBox _gridView(BuildContext context, Orientation orientation) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
          itemCount: carsName.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .001),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Text(
                      carsName[index] + '\n',
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .039,
                          fontWeight: FontWeight.bold),
                    ),
                    Image.network(
                      carsImage[index],
                      fit: BoxFit.contain,
                      width: 130,
                      height: 90,
                    ),
                    Text(
                      "${carsPrice[index]}",
                      style: TextStyle(
                        color: colorPrimary,
                        fontSize: MediaQuery.of(context).size.width * .05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "per_day_month".tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * .03,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

// return Row(
//   children: [
//     // const SizedBox(
//     //   width: 5,
//     // ),
//     Container(
//         height: 200,
//         width: 200,
//         color: Colors.white,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                     flex: 7,
//                     child: Column(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .center,
//                       crossAxisAlignment:
//                           CrossAxisAlignment
//                               .center,
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Center(
//                           child: Text(
//                             carsName[index],
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight:
//                                     FontWeight
//                                         .bold),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               "${carsPrice[index]}",
//                               style: const TextStyle(
//                                 color:
//                                     colorPrimary,
//                                 fontSize: 25,
//                                 fontWeight:
//                                     FontWeight
//                                         .bold,
//                               ),
//                             ),
//                             const Text(
//                               " per day",
//                               style: TextStyle(
//                                 color:
//                                     Colors.grey,
//                                 fontSize: 19,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20 ,
//                         ),
//                         buttonSmall(
//                             context: context,
//                             text: "Book Now",
//                             function: () {
//                               // api Id
//                               push(
//                                   context,
//                                   DetailsCar(
//                                     typeCAR:
//                                         carsName[
//                                             index],
//                                     price: 120,
//                                     firstDate:
//                                         firstDate
//                                             .text,
//                                     lastDate:
//                                         secondDate
//                                             .text,
//                                     carId: carsId[
//                                         index],
//                                   ));
//                             })
//                       ],
//                     )),
//                 Expanded(
//                     flex: 6,
//                     child: LocalizationService()
//                                 .getCurrentLocale() ==
//                             const Locale(
//                                 'ar', 'AE')
//                         ? Image.network(
//                             carsImage[index],
//                             fit: BoxFit.contain,
//                             width: 300,
//                             height: 200,
//                           )
//                         : Image.network(
//                             carsImage[index],
//                             fit: BoxFit.contain,
//                             width: 300,
//                             height: 200,
//                           )),
//               ],
//             ),
//           ],
//         )),

//   ],
// );