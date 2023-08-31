import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/controller/WishListController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/workspace.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

WishListController wishListController = Get.find();

class _WishListScreenState extends State<WishListScreen> {
  PropertyModel? propertyModel;
  bool noData=false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async{
    var response = await httpPost(Config.getWishlist, {});
    if(response!=null){
      propertyModel=PropertyModel.fromJson(response);
    }else{
      noData=true;
    }
   setState(() {
   });
  }

  stateSetter(fn) => setState(() {
  });

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        title: Text(
          "Wish List".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontStyles.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body:
      propertyModel==null?Center(child: CircularProgressIndicator(),) :
          noData==true?Center(child: Text("No Data Found"),):
          propertyModel!.data!.properties!.isEmpty?Center(child: Text("No Data Found"),):
      myList(propertyModel!.data!.properties,false, true,stateSetter),

    );
  }

  Widget univerLoader() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}



