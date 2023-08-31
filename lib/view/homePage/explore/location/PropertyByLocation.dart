import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/LocationsModel.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PropertyByLocationScreen extends StatefulWidget {
  Locations locations;
  PropertyByLocationScreen({super.key, required this.locations});

  @override
  State<PropertyByLocationScreen> createState() => PropertyByLocationState();
}

class PropertyByLocationState extends State<PropertyByLocationScreen> {
  PropertyModel? propertyModel;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await httpPost(Config.getPropertiesByLocation, {"location_id": "${widget.locations.id}"});
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
        title: Text(widget.locations.cityName!,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontStyles.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body:
        propertyModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : myList(propertyModel!.data!.properties, false, false,stateSetter),
    );
  }
}
