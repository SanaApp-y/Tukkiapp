import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/model/BookingModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:flutter/material.dart';

class MyUpCommingScreen extends StatefulWidget {
  const MyUpCommingScreen({super.key});

  @override
  State<MyUpCommingScreen> createState() => __MyUpCommingScreenStateState();
}



class __MyUpCommingScreenStateState extends State<MyUpCommingScreen> {

  BookingModel? bookingModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    Map<String, String> postData = {
      "type": "upcoming"
    };
    var result=await httpPost(Config.upcommingRecord, postData);
    if (result != null) {
      bookingModel=BookingModel.fromJson(result);
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      bookingModel == null ? Center(child: CircularProgressIndicator()):
          bookingModel!.data!.bookings!.isEmpty?Center(child: Text("'No Upcoming Booking Availability'"),):
              myBookingListWidget(bookingModel!.data!.bookings!,"Cancel")
    );
  }
}
