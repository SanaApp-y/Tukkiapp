import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/helper/RoutesHelper.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/homePage/trips/myUpcommingScreen.dart';
import 'package:Tukki/view/homePage/trips/previousBookingScreen.dart';

import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyReservationScreen extends StatefulWidget {
  const MyReservationScreen({super.key});

  @override
  State<MyReservationScreen> createState() => MyReservationState();
}

class MyReservationState extends State<MyReservationScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int index = 0;

  MyUpCommingScreen myUpCommingScreen = MyUpCommingScreen();
  PreviousookingScreen previousookingScreen = PreviousookingScreen();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, vsync: this, length: 2);
    tabController!.addListener(() {
      print(' page ${tabController!.index}');
      index = tabController!.index;
      setState(() {
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: notifire.getbgcolor,
        appBar: AppBar(
          backgroundColor: notifire.getbgcolor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: notifire.getwhiteblackcolor,
            ),
          ),
          title: Text(
            "My Booking".tr,
            style: TextStyle(
              fontSize: 17,
              fontFamily: FontStyles.gilroyBold,
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
              TabBar(
                controller: tabController,
                labelColor: CustomTheme.theamColor,
                labelStyle: TextStyle(
                    fontSize: 18,
                    fontFamily: FontStyles.gilroyMedium,
                    fontWeight: FontWeight.w700),
                unselectedLabelColor: Colors.grey,

                tabs: [
                  Tab(
                    text: 'Upcoming',
                  ),
                  Tab(
                    text: 'Previous',
                  ),
                ], // list of tabs
              ),
              SizedBox(height: 8,),
              Expanded(
                  child:
                  index==0? myUpCommingScreen:
                  previousookingScreen
              ),

            ])));
  }
}