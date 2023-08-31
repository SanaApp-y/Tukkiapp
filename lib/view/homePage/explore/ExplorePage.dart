import 'package:Tukki/model/LocationsModel.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/homePage/explore/location/SeeAllLocations.dart';
import 'package:Tukki/view/homePage/explore/SeeAllProperties.dart';
import 'package:Tukki/view/search/searchScreen.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../config/Api.dart';
import '../../../config/http_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => ExploreState();
}

class ExploreState extends State<ExploreScreen> {

  PropertyModel? propertyModel,propertyModelMost;
  LocationsModel? locationsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await httpPost(Config.yourLocation, {});
    if(response!=null){
      locationsModel=LocationsModel.fromJson(response);
    }

    var responseFeature = await httpPost(Config.featuredProperties, {});
    if(responseFeature!=null){
      propertyModel=PropertyModel.fromJson(responseFeature);
    }

    var responseMost = await httpPost(Config.mostViewedProperties, {});
    if(responseMost!=null){
      propertyModelMost=PropertyModel.fromJson(responseMost);
    }
    setState(() {});
  }

  stateSetter(fn) => setState(() {
  });

 

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    double screenWidth = MediaQuery.of(context).size.width * 0.70;
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>SearchScreen()));
                },
                  child: Row(
                    children: [

                      Row(children: [
                        Container(width: screenWidth,padding: EdgeInsets.only(left: 16),height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 2,color: CustomTheme.theamColor)),child: Row(
                          children: [
                            Image.asset(
                              'assets/images/homepagesearchicon.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 8,),
                            Text("Where do you go?",),
                          ],
                        ))
                      ],),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(width: 54,
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: CustomTheme.theamColor,
                width: MediaQuery.of(context).size.width * 0.88,

                height: 1,
                // child: Text('hello'),
              ),
              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Popular locations',
                        style: CustomTheme.homepagePopularLoaction),
                    TextButton(
                        onPressed: () {
                          // Get.toNamed(Routes.locationScreen);
                          Get.to(()=>SeeAllLocationsScreen());
                        },
                        child: const Text(
                          'see all',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),

              locationsModel==null?SizedBox(height: 170,child: Center(child: CircularProgressIndicator(),),):popularLocationsWidget(locationsModel!.data!.locations!,notifire),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommended',
                      style: CustomTheme.homepageRecommended,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(()=>SeeAllPropertiesScreen(title: "Recommended Properties"));

                        },
                        child: const Text(
                          'see all',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),

              propertyModel==null?SizedBox(height: 250,
                child: Center(child: CircularProgressIndicator()),
              ):myListHorizontal(propertyModel!.data!.properties!,stateSetter,notifire),

              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(180), // Image radius
                      child: Image.asset(
                        'assets/images/homepageimage.jpg',
                        fit: BoxFit.cover,
                        width: Get.size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 180,
                    left: 5,
                    child: Column(
                      children: [
                        const Text('Hosting Free for as',
                            textAlign: TextAlign.left,
                            style: CustomTheme.homepageimagefirstline),
                        const Row(children: [
                          Text('low as 1%. ',
                              textAlign: TextAlign.left,
                              style: CustomTheme.homepageimagesecondhalf),
                          Text(
                            'Start earning',
                            textAlign: TextAlign.start,
                            style: CustomTheme.homepageimagesecondlast,
                          ),
                        ]),
                        const Text(
                          'while sharing a room',
                          textAlign: TextAlign.start,
                          style: CustomTheme.homepageimagethirdline,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(50)),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  CustomTheme.theamColor),
                            ),
                            child: const Text(
                              'Become a Host',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Most Viewed',
                      style: CustomTheme.homepageMostView,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(()=>SeeAllPropertiesScreen(title: "Most Viewed Properties"));
                        },
                        child: const Text(
                          'see all',
                          style: TextStyle(fontSize: 15),
                        ))
                  ],
                ),
              ),
              propertyModelMost == null
                  ? const Center(child: CircularProgressIndicator(),)
                  : myList(propertyModelMost!.data!.properties!, true,false,stateSetter),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
