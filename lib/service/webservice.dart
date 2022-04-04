import 'dart:convert';

import 'package:carrent/Moudles/AvalibaleCarsMoudle.dart';
import 'package:carrent/Moudles/CarsMoudle.dart';
import 'package:http/http.dart'as http;

class GetAllCars{
 Future<List<CarsMoudle>> Allcars () async {
 http.Response response =await http.post(Uri.parse("https://lyon-jo.com/api/getCars2.php"));

 if (response.statusCode == 200){
  List<dynamic> data = jsonDecode(response.body);
  List<CarsMoudle> carlist = [];
  for (int i =0 ; i < data.length; i++){

   carlist.add(CarsMoudle.fromJson(data[i]));


  }
  return carlist;
 }else {
  throw Exception("${response.statusCode}");
 }
 }

}

// class GetAvalibaleCars{
//  Future<List<AvalibaleCarMoudle>> AvalibelCars () async {
//   http.Response response =await http.post(Uri.parse("https://lyon-jo.com/api/getAvailableCars.php"), body: {
//    "startDate": startDate.toString(),
//    "startTime": StartTime.toString(),
//    "endDate": EndDate.toString(),
//    "endTime": EndTime.toString(),
//   });
//
//   if (response.statusCode == 200){
//    List<dynamic> data = jsonDecode(response.body);
//    List<AvalibaleCarMoudle> Avalibalecarlist = [];
//    for (int i =0 ; i < data.length; i++){
//
//     Avalibalecarlist.add(AvalibaleCarMoudle.fromJson(data[i]));
//
//
//    }
//    return Avalibalecarlist;
//   }else {
//    throw Exception("${response.statusCode}");
//   }
//  }
//
// }