import 'dart:convert';

import 'package:Tukki/controller/GeneralController.dart';
import 'package:Tukki/controller/LoginController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/LoginModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/auth/loginScreen.dart';
import 'package:Tukki/view/homePage/explore/ExplorePage.dart';
import 'package:Tukki/view/homePage/inbox/InboxScreen.dart';
import 'package:Tukki/view/homePage/profile/MainProfileScreen.dart';
import 'package:Tukki/view/homePage/trips/MyReservationScreen.dart';
import 'package:Tukki/view/homePage/wishlist/WishListScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../workspace.dart';

class HomePage extends StatefulWidget {
  int initialIndex;
  HomePage({Key? key,required this.initialIndex}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ColorNotifire notifire;

  List<Widget> myChildren = [
    ExploreScreen(),
    WishListScreen(),
    MyReservationScreen(),
    InboxScreen(),
    MainProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this,initialIndex: widget.initialIndex);
    if(generalDataModel==null){
      generalController.fetchGeneralSettings();
    }
    tabController.addListener(() {
      generalController.currentIndex.value=tabController.index;
    });

    getUserData();
  }
  getUserData() async {
    UserloginController userLoginController = Get.put(UserloginController());
    userLoginController.getUserLocation();
    await GetStorage().initStorage;
    String data= await GetStorage().read("UserData");
    if(data.isNotEmpty){
      try{
        var json=jsonDecode(data);
        LoginModel loginModel=LoginModel.fromJson(json);

        if(loginModel.data!=null){
          if(loginModel.data!.token!=null){
            token=loginModel.data!.token!;
          }
          if(loginModel.data!.firstName!=null){
            firstName=loginModel.data!.firstName!;
          }
          if(loginModel.data!.profileImage!=null){
            profileImage=loginModel.data!.profileImage;
          }
        }else{
          showToastMessage("Token now found! login again");
          Get.offAll(()=>LoginScreen());
        }
      }catch(e){
        showToastMessage("Token now found! login again");
        Get.offAll(()=>LoginScreen());
      }
    }else{
      showToastMessage("Token now found! login again");
      Get.offAll(()=>LoginScreen());
    }

  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

    return Obx(() =>
    generalController.failed.value==true?Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text("Something went wrong"),
        SizedBox(height: 16,),
        InkWell(onTap: (){
          generalController.fetchGeneralSettings();
        },child: Container(padding: EdgeInsets.only(top: 16,bottom: 16,left: 32,right: 32),decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20)),child: Text("Reload",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
      ],
    ),),):
    generalController.hasGeneralData.value==false?
    Scaffold(body: Center(child: CircularProgressIndicator(),),):

    Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChildren,
      ),
      floatingActionButton: InkWell(onTap: (){
        generalController.currentIndex.value=2;
        tabController.index=2;
      },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
                width: 5.0, color: Colors.white, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(50),
            color: WhiteColor,
          ),
          child: Center(
            child: Image.asset(
              ('assets/images/Frame 5.png'),
              height: 50,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 248, 236, 217),
        child: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: notifire.getbgcolor, width: 2),
            insets: EdgeInsets.only(bottom: 52),
          ),
          controller: tabController,
          padding: const EdgeInsets.symmetric(vertical: 6),
          tabs: [
            Tab(
              child: Column(
                children: [
                  generalController.currentIndex.value == 0
                      ? Image.asset(
                    "assets/images/Search.png",
                    scale: 1,
                    color: CustomTheme.theamColor,
                  )
                      : Image.asset(
                    "assets/images/Search.png",
                    scale: 1,
                    color: Colors.black,
                  ),
                  Text(
                    "Explore".tr,
                    style: TextStyle(fontSize: 12,
                      color:generalController.currentIndex.value == 0 ? CustomTheme.theamColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Tab(
              child: Column(
                children: [
                  generalController.currentIndex.value == 1
                      ? Image.asset(
                    "assets/images/Heart.png",
                    scale: 1,
                    color: CustomTheme.theamColor,
                  )
                      : Image.asset(
                    "assets/images/Heart.png",
                    scale: 1,
                    color: Colors.black,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Wishlist".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontStyles.gilroyMedium,
                      color:
                      generalController.currentIndex.value == 1 ? CustomTheme.theamColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  generalController.currentIndex.value == 2 ? Text('df') : Text(''),
                  SizedBox(height: 15),
                  Text(
                    "Trips".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontStyles.gilroyMedium,
                      color:
                      generalController.currentIndex.value == 2 ? CustomTheme.theamColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Tab(
              child: Column(
                children: [
                  generalController.currentIndex.value == 3
                      ? Image.asset(
                    "assets/images/Chat.png",
                    scale: 1,
                    color: CustomTheme.theamColor,
                  )
                      : Image.asset(
                    "assets/images/Chat.png",
                    scale: 1,
                    color: Colors.black,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Inbox".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontStyles.gilroyMedium,
                      color:
                      generalController.currentIndex.value == 3 ? CustomTheme.theamColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            Tab(
              child: Column(
                children: [
                  generalController.currentIndex.value == 4
                      ? Image.asset(
                    "assets/images/Profile1.png",
                    scale: 1,
                    color: CustomTheme.theamColor,
                  )
                      : Image.asset(
                    "assets/images/Profile1.png",
                    scale: 1,
                    color: Colors.black,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Profile".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontStyles.gilroyMedium,
                      color:
                      generalController.currentIndex.value == 4 ? CustomTheme.theamColor : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}