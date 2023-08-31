import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/controller/GeneralController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/PropertyDetailsModel.dart';
import 'package:Tukki/model/StaticModel.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/booking/BookRealEstateScreen.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final dynamic id;

  const PropertyDetailsScreen({super.key, required this.id});

  @override
  State<PropertyDetailsScreen> createState() => PropertyDetailsState();
}

class PropertyDetailsState extends State<PropertyDetailsScreen> {
  bool isExpanded = false;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> isExpand = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isExpandedHouse = ValueNotifier<bool>(false);
  final PageController _pagereviewController = PageController();
  PageController _pageControllerslider = PageController();
  final ValueNotifier<int> _currentPageSliderNotifier = ValueNotifier<int>(0);


  PropertyDetailsModel? propertyDetailsModel;
  bool houseRuleLoading=false;
  bool cancellationLoading=false;


  @override
  void initState() {
    super.initState();
    _pageControllerslider = PageController();
    _pageControllerslider.addListener(() {
      if (_pageControllerslider.page != null) {
        _currentPageSliderNotifier.value = _pageControllerslider.page!.round();
      }
    });
    getData();
  }
  getData() async {
    var response = await httpPost(Config.getPropertyDetails, {"property_id": "${widget.id}"});
    if(response!=null){
      propertyDetailsModel=PropertyDetailsModel.fromJson(response);
    }
    setState(() {
    });
  }

  @override
  void dispose() {
    _pagereviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return  Scaffold(
          body: propertyDetailsModel==null?const Center(child: CircularProgressIndicator(),):

          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.white,
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      alignment:
                      Alignment.bottomCenter, // Align to the bottom
                      children: [
                        PageView.builder(
                          controller:
                          _pageControllerslider, // Add the controller here
                          scrollDirection: Axis.horizontal,
                          itemCount: propertyDetailsModel!.data!.propertyDetails!.galleryImageUrls!.length,
                          itemBuilder: (context, index) {
                            return FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeInCirc,
                              placeholder:
                              "assets/images/ezgif.com-crop.gif",
                              height: 50,
                              image: propertyDetailsModel!.data!.propertyDetails!.galleryImageUrls!
                                  .elementAt(index) ??
                                  "",
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _currentPageSliderNotifier,
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    propertyDetailsModel!.data!.propertyDetails!.galleryImageUrls!.length,
                                        (index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: value == index
                                              ? CustomTheme.theamColor
                                              : Colors.grey,
                                        ),
                                      );
                                    }),
                              ),
                            );
                          },
                        ),const Positioned(child: Icon(Icons.arrow_back),top: 50,left: 20,)
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(propertyDetailsModel!.data!.propertyDetails!.title ?? "",
                      maxLines: 3,
                      style: const TextStyle(fontSize: 20, fontFamily: FontStyles.gilroyMedium, fontWeight: FontWeight.w800, color: CustomTheme.theamColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Property type: ${propertyDetailsModel!.data!.propertyDetails!.propertyType ?? ""}",
                          style: const TextStyle(fontSize: 15),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Location: ${propertyDetailsModel!.data!.propertyDetails!.city}, ${propertyDetailsModel!.data!.propertyDetails!.stateRegion ?? ""}",
                        style: TextStyle(
                            fontSize: 15, color: greyColor)),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),

                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/profilephotojpg.jpg",
                            height: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hosted By ${propertyDetailsModel!.data!.propertyDetails!.hostFirstName} ",
                              style: const TextStyle(
                                  fontFamily:
                                  FontStyles.gilroyMedium,
                                  color: CustomTheme.theamColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),

                            ),
                            SizedBox(height: 4,),
                            const Text('View Profile'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.50,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/Beds.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${propertyDetailsModel!.data!.propertyDetails!.beds ?? ""} Beds",
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.40,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/Cars.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('3 Parking Lot')
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.50,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/Zym.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('1 Gym Room')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.40,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/sqft.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${propertyDetailsModel!.data!.propertyDetails!.propertySqft ?? ""} SQFT",
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.50,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/Bathroom.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${propertyDetailsModel!.data!.propertyDetails!.bathroom ?? ""} Bathroom",
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.40,
                          child: Row(
                            children: [
                              Image.asset(
                                  'assets/images/Cars.png'),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('3 Padfjnkjnm Lot')
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),

                    const Text('Preferred Check-in',
                        style: TextStyle(
                            fontFamily:
                            FontStyles.gilroyMedium,
                            color: CustomTheme.theamColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                    SizedBox(
                      height: 8,
                    ),
                    const Text('Check In : Flexible'),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),

                    Text('About the Place',
                        style: TextStyle(
                            fontFamily:
                            FontStyles.gilroyMedium,
                            color: CustomTheme.theamColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(propertyDetailsModel!.data!.propertyDetails!.description ?? "",),
                     SizedBox(
                      height: 8,
                    ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),
                    const Text('Min / Max Night',
                        style: TextStyle(
                            fontFamily:
                            FontStyles.gilroyMedium,
                            color: CustomTheme.theamColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                    SizedBox(
                      height: 5,
                    ),
                    Text('1 Min Night'),

                    const SizedBox(
                      height: 8,
                    ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),
                    const SizedBox(
                      height: 8,
                    ),
                    Text('Amenities',
                        style: TextStyle(
                            fontFamily:
                            FontStyles.gilroyMedium,
                            color: CustomTheme.theamColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: propertyDetailsModel!.data!.propertyDetails!.amenities!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          mainAxisExtent: 35,
                      ),
                      itemBuilder: (context, index) {
                        final amenity = propertyDetailsModel!.data!.propertyDetails!.amenities![index];
                        return Row(
                          children: [
                            Container(
                                // decoration: BoxDecoration(
                                //   color: Colors.red,
                                //   borderRadius:
                                //   BorderRadius.circular(17),
                                // ),
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                  child: Image.network(
                                    amenity.imageUrl!,
                                    fit: BoxFit.fill,
                                    width: 20,
                                    height: 20,
                                  ),
                                )),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.all(
                                  5), // Add some padding
                              // color: RedColor,
                              child: Text(
                                amenity.name!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontStyles.gilroyBold,
                                ),
                                // Add overflow handling
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('You will be here',
                                style: TextStyle(
                                    fontFamily: FontStyles.gilroyMedium,
                                    color: CustomTheme.theamColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1)),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Image.asset('assets/images/Map.jpg'),

                        SizedBox(height: 300,child: GoogleMap(markers: {Marker(markerId: MarkerId("1"),position: LatLng(double.parse(propertyDetailsModel!.data!.propertyDetails!.latitude!), double.parse(propertyDetailsModel!.data!.propertyDetails!.longitude!)))}
                            ,initialCameraPosition: CameraPosition(target: LatLng(double.parse(propertyDetailsModel!.data!.propertyDetails!.latitude!), double.parse(propertyDetailsModel!.data!.propertyDetails!.longitude!)),zoom: 12)),)
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(color: CustomTheme.theamColor,thickness: 1,),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/Rating.png',
                              height: 20,
                            ),
                            Text(
                              // '  ${snapshot.data!.reviews!.first.rating!}   / Review (${snapshot.data!.propertyDetailsModel!.data!.propertyDetails!.totalReviews ?? ""})',
                                '/ Review (${propertyDetailsModel!.data!.propertyDetails!.totalReviews ?? "No review Here"})',
                                style: const TextStyle(
                                    fontFamily:
                                    FontStyles.gilroyMedium,
                                    color: CustomTheme.theamColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1)),
                            const Spacer(),
                            propertyDetailsModel!.data!.propertyDetails!.reviews!.isEmpty?SizedBox():TextButton(onPressed: (){}, child: const Text('See all')),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        //
                        propertyDetailsModel!.data!.propertyDetails!.reviews!.isEmpty?SizedBox():SizedBox(
                          // color: RedColor,
                          height: 100,
                          child: PageView.builder(
                            controller: _pagereviewController,
                            onPageChanged: (index) {
                              _currentPageNotifier.value = index;
                            },
                            itemCount: propertyDetailsModel!.data!.propertyDetails!.reviews!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(50),
                                        child: Image.network(
                                          propertyDetailsModel!.data!.propertyDetails!
                                              .reviews![index]
                                              .guestProfileImage!,
                                          height: 40,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            propertyDetailsModel!.data!.propertyDetails!
                                                .reviews![
                                            index]
                                                .guestName!,
                                            style: const TextStyle(
                                                fontFamily:
                                                FontStyles
                                                    .gilroyMedium,
                                                color: CustomTheme
                                                    .theamColor,
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight
                                                    .w700,
                                                letterSpacing:
                                                1),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/Rating.png',
                                                height: 15,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                'assets/images/Rating.png',
                                                height: 15,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                'assets/images/Rating.png',
                                                height: 15,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Image.asset(
                                                'assets/images/Rating.png',
                                                height: 15,
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            propertyDetailsModel!.data!.propertyDetails!
                                                .reviews![
                                            index]
                                                .message!,
                                            style: const TextStyle(
                                                fontSize:
                                                15,
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            propertyDetailsModel!.data!.propertyDetails!
                                                .reviews![
                                            index]
                                                .updatedAt!,
                                            style: TextStyle(
                                                color:
                                                greyColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        ValueListenableBuilder<int>(
                          valueListenable: _currentPageNotifier,
                          builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: List.generate(
                                propertyDetailsModel!.data!.propertyDetails!.reviews!
                                    .length, // Same as itemCount in PageView
                                    (index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: value == index
                                          ? CustomTheme.theamColor
                                          : Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                         SizedBox(
                          height: propertyDetailsModel!.data!.propertyDetails!.reviews!.isEmpty?0:16,
                        ),
                        Divider(color: CustomTheme.theamColor,thickness: 1,),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'House Rules',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () async {
                                  houseRuleLoading=true;
                                  setState(() {
                                  });
                                  var response = await httpPost(Config.staticPage, {"id":"3"});
                                  houseRuleLoading=false;
                                  setState(() {
                                  });
                                  if(response!=null){
                                    StaticModel staticModel=StaticModel.fromJson(response);
                                    webBottomModel(context,"House Rules",staticModel);
                                  }
                                  },
                                child: houseRuleLoading?SizedBox(height: 25,width: 25,child: CircularProgressIndicator()):const Text(
                                  "Read",
                                  style: TextStyle(
                                      color: CustomTheme.theamColor,
                                      fontSize: 15),
                                ))
                          ],
                        ),
                        Divider(color: CustomTheme.theamColor,thickness: 1,),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Cancellation policy',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () async {
                                 cancellationLoading=true;
                                 setState(() {
                                 });
                                 var response = await httpPost(Config.staticPage, {"id":"6"});
                                 cancellationLoading=false;
                                 setState(() {
                                 });
                                 if(response!=null){
                                   StaticModel staticModel=StaticModel.fromJson(response);
                                   webBottomModel(context,"Cancellation Policy",staticModel);
                                 }
                                },
                                child: cancellationLoading?SizedBox(height: 25,width: 25,child: CircularProgressIndicator()):const Text(
                                  "Flexible",
                                  style: TextStyle(
                                      color: CustomTheme.theamColor,
                                      fontSize: 15),
                                ))
                          ],
                        ),
                        Divider(color: CustomTheme.theamColor,thickness: 1,),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Availability',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Check",
                                  style: TextStyle(
                                      color: CustomTheme.theamColor,
                                      fontSize: 15),
                                ))
                          ],
                        ),
                        Divider(color: CustomTheme.theamColor,thickness: 1,),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Contact host',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Message",
                                  style: TextStyle(
                                      color: CustomTheme.theamColor,
                                      fontSize: 15),
                                ))
                          ],
                        ),
                        Container(
                          color: CustomTheme.theamColor,
                          height: 1,
                          width: 340,
                        ),
                        Container(
                          height: 50,
                        ),

                        SizedBox(
                            height: 50,
                            child: Text(
                              "Raghav Tomar",
                              style: TextStyle(color: greyColor),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

      bottomSheet:
      propertyDetailsModel==null?SizedBox(): Material(elevation: 10,
        child: Container(
          padding: EdgeInsets.all(16),
          height: 80,
          color: Colors.grey.shade200, // Adjust the height as needed

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${generalDataModel!.data!.metaData!.generalDefaultCurrency!} ${propertyDetailsModel!.data!.propertyDetails!.price} ',
                      style: CustomTheme.mostviewtitle),
                  const Text('/night',
                      style: TextStyle(
                          fontSize: 15,
                          color: CustomTheme.theamColor)),
                ],
              ),

              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookRealEstate(idFeatured: propertyDetailsModel!.data!.propertyDetails!.propertyId , propertyDetails: propertyDetailsModel!.data!.propertyDetails!,)));
              },child: Container(padding: EdgeInsets.only(left: 32,right: 32,top: 16,bottom: 16),decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: CustomTheme.theamColor),child: Text("Book".tr,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16)),)),
            ],
          ),
        ),
      ),
    );
    
  }

  webBottomModel(BuildContext context,string,StaticModel staticModel) async {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
                // height:
                //     500, // Set a specific height or use `double.infinity` for full height
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          textAlign: TextAlign.justify,
                          "$string",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                       WebViewX(width: Get.width, height: Get.height,initialSourceType: SourceType.html,initialContent: staticModel.data!.staticPage!.content!.tr),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }



}
