import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SeeAllPropertiesScreen extends StatefulWidget {
  String title;
  SeeAllPropertiesScreen({super.key,required this.title});

  @override
  State<SeeAllPropertiesScreen> createState() => SeeAllPropertiesState();
}


class SeeAllPropertiesState extends State<SeeAllPropertiesScreen> {

  PropertyModel? propertyModel;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response;
    if(widget.title=="Most Viewed Properties"){
      response = await httpPost(Config.mostViewedProperties, {});
    }else{
      response = await httpPost(Config.featuredProperties, {});
    }
    if(response!=null){
      propertyModel=PropertyModel.fromJson(response);
    }

    setState(() {});
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
          widget.title.tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontStyles.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: propertyModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : myList(propertyModel!.data!.properties, false,false,stateSetter),
    );
  }
}
