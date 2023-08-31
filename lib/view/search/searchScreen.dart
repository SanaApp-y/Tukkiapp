import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/controller/filterController.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_theme.dart';
import 'FilterScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  FilterController filterController=Get.find();
  bool filterAvailable=false;
  PropertyModel? propertyModel;


  searchMethod(value) async {

    String price="${filterController.currentRangeValues.start}-${filterController.currentRangeValues.end}";
    var result=await searchProperty(value,"${filterController.selectedPropertyList}",price,"${filterController.selectedBeds}","${filterController.selectedBeds}","${filterController.selectedAmenitiesList}","10","0");
    try{
      propertyModel=PropertyModel.fromJson(result);
      setState(() {
      });
    }catch(e){
    }
  }

  searchProperty(String title,String propertyType,String price,String beds,String bathroom,String facility,String limit,String offset) async {
    Map map={
      "title":title,
      "property_type":propertyType,
      "price":price,
      "beds":beds,
      "bathroom":bathroom,
      "facility":facility,
      "limit":limit,
      "offset":offset
    };

    return await httpPost(Config.searchProperty, map);
  }


  @override
  void dispose() {
    filterController.selectedAmenitiesList = [].obs;
    filterController.selectedPropertyList = [].obs;
    filterController.selectedBeds=1;
    filterController.selectedBathroom=1;
    filterController.showMore=true;
    filterController.currentRangeValues = const RangeValues(0, 1000);


    super.dispose();
  }

  stateSetter(fn) => setState(() {
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,automaticallyImplyLeading: false,title:  Padding(
        padding: const EdgeInsets.only(top: 4.0,bottom: 4),
        child: Row(
          children: [
            Expanded(
              child: Container(decoration: BoxDecoration(border: Border.all(color: CustomTheme.theamColor,width: 2,),borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(width: 8,),
                    Image.asset(
                      'assets/images/homepagesearchicon.png',
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: 4,),
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                          searchMethod(value);
                        },
                        decoration: InputDecoration(
                            hintText: 'Where do you go?',
                            hintStyle: const TextStyle(
                              // fontFamily: FontStyles.gilroyMedium
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(width: 54,
              child: Stack(
                children: [
                  InkWell(onTap: () async {
                    var value=await Navigator.push(context, MaterialPageRoute(builder: (builder)=>FilterScreen()));
                    if(value!=null){
                      filterAvailable=true;
                    }else{
                      filterAvailable=false;
                    }
                    setState(() {
                    });
                  },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomTheme.theamColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10),
                        color: CustomTheme.theamColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          ('assets/images/Filter.png'),
                        ),
                      ),
                    ),
                  ),
                  !filterAvailable?SizedBox():Positioned(right: 0,child: Container(height: 10,width: 10,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(20)),)),
                ],
              ),
            ),
          ],
        ),
      ),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            propertyModel==null?SizedBox():Container(margin: EdgeInsets.only(top: 16),
              child: myList(propertyModel!.data!.properties!, true, false, stateSetter,),)
          ],),
        ),
      )
    );
  }
}
