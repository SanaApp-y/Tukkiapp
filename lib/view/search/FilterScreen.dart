import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/controller/GeneralController.dart';
import 'package:Tukki/controller/filterController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/AmenitiesModel.dart';
import 'package:Tukki/model/PropertyTypeModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';

import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_theme.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

// AmienitesController amientesdata = Get.find();

class _FilterScreenState extends State<FilterScreen> {
  AmenitiesModel? amenitiesModel;
  PropertyTypeModel? propertyTypeModel;
  FilterController filterController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    var response = await httpPost(Config.amenities,{});
    if(response!=null){
      amenitiesModel=AmenitiesModel.fromJson(response);
    }

    var responseType = await httpPost(Config.propertyType,{});
    if(response!=null){
      propertyTypeModel=PropertyTypeModel.fromJson(responseType);

    }

    setState(() {});
  }

  submitMethod(){
    if(filterController.selectedPropertyList.isNotEmpty || filterController.selectedAmenitiesList.isNotEmpty || filterController.selectedBeds>1 || filterController.selectedBathroom>1){
      Navigator.pop(context,"true");
    }else{
      Navigator.pop(context);
    }
  }
  clearFilter(){
    filterController.selectedPropertyList=[];
    filterController.selectedAmenitiesList=[];
    filterController.selectedBeds=1;
    filterController.selectedBathroom=1;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              submitMethod();
            },
            icon: Icon(
              Icons.arrow_back,
              color: notifire.getwhiteblackcolor,
            )),
        title: Text(
          'Filter',
          style: TextStyle(
              fontSize: 17,
              fontFamily: FontStyles.gilroyBold,
              color: notifire.getwhiteblackcolor),
        ),
        actions: [
          Container(
          padding: const EdgeInsets.only(right: 16),
          child: Center(
            child: InkWell(onTap: (){
              clearFilter();
              },child: Text("Clear",style: TextStyle(color: Colors.cyan),)),
          ),
        )],
      ),
      body: propertyTypeModel == null
                  ? Center( child: CircularProgressIndicator(),)
                  :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Property Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (int i=0;i< propertyTypeModel!.data!.propertyTypes!.length;i++)
                  // for (PropertyTypes item in propertyData!.propertyTypes!)
                    i==5&&filterController.showMore?InkWell(onTap: (){
                      filterController.showMore=false;
                      setState(() {

                      });
                    },child: Container(padding: EdgeInsets.only(top: 10,bottom: 8,left: 16,right: 16),child: Text('show more',style: TextStyle(color: CustomTheme.theamColor,fontWeight: FontWeight.bold),))): i>5&&filterController.showMore?SizedBox(): InkWell(
                      onTap: (() {
                        if(!filterController.selectedPropertyList.contains(propertyTypeModel!.data!.propertyTypes![i].id)){
                          filterController.selectedPropertyList.add(propertyTypeModel!.data!.propertyTypes![i].id);
                        }else{
                          filterController.selectedPropertyList.remove(propertyTypeModel!.data!.propertyTypes![i].id);
                        }
                        setState(() {});
                      }),
                      child: Container(
                        padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                        decoration: BoxDecoration(
                          color:filterController.selectedPropertyList.contains(propertyTypeModel!.data!.propertyTypes![i].id)
                              ? CustomTheme.theamColor
                              : Colors.white,
                          border: Border.all(
                            color: CustomTheme.theamColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          propertyTypeModel!.data!.propertyTypes![i].name!,
                          style: TextStyle(
                            color: filterController.selectedPropertyList.contains(propertyTypeModel!.data!.propertyTypes![i].id)
                                ? Colors.white
                                : BlackColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              RangeSlider(
                activeColor: CustomTheme.theamColor,
                values: filterController.currentRangeValues,
                max: 1000,
                divisions: 1000,
                labels: RangeLabels(
                  filterController.currentRangeValues.start.round().toString(),
                  filterController.currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    filterController.currentRangeValues = values;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // '${generalDataModel!.data!.metaData!.generalDefaultCurrency}'
                      '${generalDataModel!.data!.metaData!.generalDefaultCurrency!} ${filterController.currentRangeValues.start.round().toString()}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CustomTheme.theamColor),
                    ),
                    Text('${generalDataModel!.data!.metaData!.generalDefaultCurrency!} ${filterController.currentRangeValues.end.round().toString()}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CustomTheme.theamColor)),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'People',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(onTap: (){
                    if(filterController.selectedBeds!=1){
                      filterController.selectedBeds--;
                      setState(() {
                      });
                    }
                  },
                    child: Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),

                  Container(
                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                    decoration: BoxDecoration(
                      color: CustomTheme.theamColor,
                      border: Border.all(
                        color: CustomTheme.theamColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${filterController.selectedBeds}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 16,),
                  InkWell(onTap: (){
                    filterController.selectedBeds++;
                    setState(() {
                    });
                  },
                    child: Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 16,
              ),
              Text(
                'Bathroom',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  InkWell(onTap: (){
                    if(filterController.selectedBathroom!=1){
                      filterController.selectedBathroom--;
                      setState(() {
                      });
                    }
                  },
                    child: Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "-",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),

                  Container(
                    padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                    decoration: BoxDecoration(
                      color: CustomTheme.theamColor,
                      border: Border.all(
                        color: CustomTheme.theamColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "${filterController.selectedBathroom}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 16,),
                  InkWell(onTap: (){
                    filterController.selectedBathroom++;
                    setState(() {
                    });
                  },
                    child: Container(
                      padding: EdgeInsets.only(top: 8,bottom: 8,left: 16,right: 16),
                      decoration: BoxDecoration(
                        // color: Colors.green,
                        border: Border.all(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "+",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Facility',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              amenitiesModel == null
                  ? SizedBox()
                  : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: amenitiesModel!.data!.amenities!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    mainAxisExtent: 50),
                itemBuilder: (context, index) {
                  // final amenity =
                  //     snapshot.data!.propertyDetails!.amenities![index];
                  return Container(
                    // color: blueColor,
                    // height: MediaQuery.of(context).size.width * 0.1,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        // Container(child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Inage,),),
                        // Change height to width here
                        Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                amenitiesModel!.data!.amenities!.elementAt(index).image!,
                                fit: BoxFit.fill,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(17),
                            )),
                        SizedBox(width: 10),
                        Expanded(
                          // Wrap the Text widget with Expanded
                          child: Container(
                            padding: const EdgeInsets.all(
                                5), // Add some padding
                            // color: RedColor,
                            child: Text(
                              amenitiesModel!.data!.amenities!.elementAt(index).name!,
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: FontStyles.gilroyBold,
                              ),
                              // Add overflow handling
                            ),
                          ),
                        ),
                        Checkbox(
                          value: filterController.selectedAmenitiesList.contains(amenitiesModel!.data!.amenities![index].id)
                              ? true
                              : false,
                          onChanged: ((value) {
                            if (value == true) {
                              if (!filterController.selectedAmenitiesList.contains(amenitiesModel!.data!.amenities![index].id)) {
                                filterController.selectedAmenitiesList.add(amenitiesModel!.data!.amenities![index].id);
                              }
                            } else {
                              filterController.selectedAmenitiesList.remove(amenitiesModel!.data!.amenities![index].id);
                            }

                            setState(() {});
                          }),
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestButton(
                height: 50,
                buttoncolor: blueColor,
                buttontext: "Apply".tr,
                style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () async {
                  submitMethod();
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
