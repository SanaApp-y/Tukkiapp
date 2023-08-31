
import 'package:Tukki/controller/GeneralController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/BookingModel.dart';
import 'package:Tukki/model/LocationsModel.dart';
import 'package:Tukki/model/PropertyModel.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/homePage/explore/PropertyDetailsScreen.dart';
import 'package:Tukki/view/homePage/explore/location/PropertyByLocation.dart';
import 'package:Tukki/view/homePage/wishlist/WishListScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


popularLocationsWidget(List<Locations> list,notifire){
  return SizedBox(
      height: 170,
      child: ListView.builder(
        // itemCount: 10,
        itemCount: list.length,
        // physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyByLocationScreen(locations: list[index],)));
            },
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: notifire.getblackwhitecolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: 130,
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            fadeInCurve: Curves.easeInCirc,
                            placeholder:
                            "assets/images/ezgif.com-crop.gif",
                            height: 140,
                            image: list
                                .elementAt(index)
                                .image ??
                                "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(width: 130,
                            child: Container(padding: const EdgeInsets.all(8),decoration: BoxDecoration(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),gradient: LinearGradient(colors: [
                              CustomTheme.theamColor.withOpacity(.3),
                              CustomTheme.theamColor.withOpacity(.4),
                              CustomTheme.theamColor.withOpacity(.5),
                              CustomTheme.theamColor.withOpacity(.6),
                              CustomTheme.theamColor.withOpacity(.7),
                              CustomTheme.theamColor.withOpacity(.8),
                              CustomTheme.theamColor.withOpacity(.9),
                              CustomTheme.theamColor.withOpacity(1),
                            ],
                              begin:Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    list
                                        .elementAt(index)
                                        .cityName!.length>10?list
                                        .elementAt(index)
                                        .cityName!.substring(0,9):list
                                        .elementAt(index)
                                        .cityName ??
                                        "",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )
  );
}

int wishListLoadingHorizontal=-1;
myListHorizontal(List<Properties> list,StateSetter setState,notifire){
  return SizedBox(height: 250,
    child: ListView.builder(
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      // physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailsScreen(id: list.elementAt(index).id)));
          },
          child: Column(
            children: [
              Container(
                height: 170,
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 180,
                          width: 250,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeInCirc,
                              placeholder:
                              "assets/images/ezgif.com-crop.gif",
                              height: 140,
                              image: list
                                  .elementAt(index)
                                  .image ??
                                  "",imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/ezgif.com-crop.gif");
                            },
                              fit: BoxFit.cover,

                            ),
                          ),
                        ),

                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: wishListLoadingHorizontal==index?Colors.transparent:const Color(0xFFedeeef),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                wishListLoadingHorizontal==index? const SizedBox(height: 25,width: 25,child: CircularProgressIndicator()) :InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: Image.asset(
                                      "assets/images/HeartTheamcolor.png",
                                      height: 20,
                                      width: 20,
                                      color: list[index].isInWishlist == false?Colors.orange:Colors.red,
                                    ),
                                  ),
                                  onTap: () async {
                                    wishListLoadingHorizontal=index;
                                    setState((){});

                                    if (list[index].isInWishlist == false){
                                      var value=await wishListController.addTowishlist(list[index].id);


                                      if(value==true){
                                        var vvv = list[index];
                                        vvv.wishlistSetter = true;
                                        list[index]=vvv;
                                      }
                                    }else{
                                      var value= await wishListController.removeToWishlist(list[index].id);

                                      if(value==true){
                                        var vvv = list[index];
                                        vvv.wishlistSetter = false;
                                        list[index]=vvv;
                                      }
                                    }
                                    wishListLoadingHorizontal=-1;
                                    setState((){});
                                  },
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontFamily: FontStyles.gilroyMedium,
                                    color: blueColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment:
                        //         CrossAxisAlignment.start,
                        //     children: [
                        //       Row(
                        //         children: [],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),

                  ],
                ),
              ),
              Container(
                height: 80,
                width: 250,
                // color: RedColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text.rich(TextSpan(
                              text: "${generalDataModel!.data!.metaData!.generalDefaultCurrency} ${list.elementAt(index).price }",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: CustomTheme.theamColor,
                                  fontWeight: FontWeight.w600),
                              children: const <InlineSpan>[
                                TextSpan(
                                  text: ' /night',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ])),

                        ),
                        const SizedBox(width: 8,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: CustomTheme.theamColor,
                              size: 15,
                            ),
                            Text(
                                list
                                    .elementAt(index)
                                    .propertyRating! ??
                                    "",
                                style: CustomTheme.featuredsliderrating)
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(list.elementAt(index).name!.length>21? list.elementAt(index).name!.substring(0,20): list.elementAt(index).name! ?? "", style: CustomTheme.featuredsliderdescription,),
                      ],
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Text('${list.elementAt(index).propertyType!}/',
                          style: CustomTheme.featuredsliderhome,
                        ),
                        Text('${list.elementAt(index).beds!} beds',
                          style: CustomTheme.featuredsliderbeds,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

int wishListLoading=-1;
myList(list, shrink, fromWishList, StateSetter setState) {

  return ListView.builder(
      shrinkWrap: shrink,
      physics: shrink == false
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemCount: shrink == true
          ? list!.length > 4
          ? 4
          : list!.length
          : list!.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(
                          width: Get.size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(10), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(180), // Image radius
                              child: FadeInImage.assetNetwork(
                                fadeInCurve: Curves.easeInCirc,
                                placeholder: "assets/images/ezgif.com-crop.gif",
                                height: 50,
                                image: "${list![index].image}",
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/ezgif.com-crop.gif",fit: BoxFit.fill,);
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: Container(
                            decoration: BoxDecoration(
                              color: wishListLoading==index?Colors.transparent:const Color(0xFFedeeef),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                wishListLoading==index? const SizedBox(height: 25,width: 25,child: CircularProgressIndicator()) :InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    child: Image.asset(
                                      "assets/images/HeartTheamcolor.png",
                                      height: 20,
                                      width: 20,
                                      color: list[index].isInWishlist == false?Colors.orange:Colors.red,
                                    ),
                                  ),
                                  onTap: () async {
                                    wishListLoading=index;
                                    setState((){});

                                    if (list[index].isInWishlist == false){
                                      var value=await wishListController.addTowishlist(list[index].id);

                                      if(value==true){
                                        var vvv = list![index];
                                        vvv.wishlistSetter = true;
                                        list[index]=vvv;
                                      }
                                    }else{
                                      var value= await wishListController.removeToWishlist(list[index].id);

                                      if(value==true){
                                        if (fromWishList == true) {
                                          list.removeAt(index);
                                        }else{
                                          var vvv = list![index];
                                          vvv.wishlistSetter = false;
                                          list[index]=vvv;
                                        }
                                      }
                                    }
                                    wishListLoading=-1;
                                    setState((){});
                                  },
                                ),
                                Text(
                                  "",
                                  style: TextStyle(
                                    fontFamily: FontStyles.gilroyMedium,
                                    color: blueColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text.rich(TextSpan(
                                  text: "${generalDataModel!.data!.metaData!.generalDefaultCurrency} ${list![index].price}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: CustomTheme.theamColor,
                                      fontWeight: FontWeight.w600),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: ' /night',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: CustomTheme.theamColor,
                                  size: 15,
                                ),
                                Text("${list![index].propertyRating}",
                                    style: CustomTheme.featuredsliderrating)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${list![index].name!.length > 40 ? list![index].name!.substring(0, 39) : list![index].name!}",
                                style: CustomTheme.mostviewdescription,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.s,
                            children: [
                              Text(
                                "${list![index].propertyType} ",
                                style: CustomTheme.mostviewhome,
                              ),
                              Text(
                                "/ ${list![index].beds} beds",
                                style: CustomTheme.mostviewbeds,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              )),
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailsScreen(id: list!.elementAt(index).id)));
          },
        );
      });
}


myBookingListWidget(List<Bookings> list,btnText) {

  return ListView.builder(
      shrinkWrap: true,
      itemCount:  list.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: Get.size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10), // Image border
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(180), // Image radius
                            child: FadeInImage.assetNetwork(
                              fadeInCurve: Curves.easeInCirc,
                              placeholder: "assets/images/ezgif.com-crop.gif",
                              height: 50,
                              image: "${list[index].propImg}",
                              imageErrorBuilder:
                                  (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/ezgif.com-crop.gif",fit: BoxFit.fill,);
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(top: 10,right: 10,child: Container(padding: EdgeInsets.all(8),decoration: BoxDecoration(color: CustomTheme.theamColor,borderRadius: BorderRadius.circular(10)),child: Text(list[index].paymentStatus!,style: TextStyle(color: Colors.white),)))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text.rich(TextSpan(
                                text: "${generalDataModel!.data!.metaData!.generalDefaultCurrency} ${list[index].total}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: CustomTheme.theamColor,
                                    fontWeight: FontWeight.w600),
                                children:  <InlineSpan>[
                                  TextSpan(
                                    text: ' / ${list[index].totalNight} ${int.parse("${list[index].totalNight}")>1?'nights':'night'}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ])),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                color: CustomTheme.theamColor,
                                size: 15,
                              ),
                              Text("${list[index].rating}",
                                  style: CustomTheme.featuredsliderrating)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${list[index].propTitle!.length > 40 ? list[index].propTitle!.substring(0, 39) : list[index].propTitle!}",
                              style: CustomTheme.mostviewdescription,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(children: [
                        Expanded(child: Container(padding: EdgeInsets.all(12),decoration: BoxDecoration(color:btnText!="Cancel"? CustomTheme.theamColor:Colors.red,borderRadius: BorderRadius.circular(10)),child: Center(child: Text(btnText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)))),
                        SizedBox(width: 16,),
                        Expanded(child: Container(padding: EdgeInsets.all(12),decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),child: Center(child: Text("E-Reciept",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))))
                      ],),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              )),
          onTap: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PropertyDetailsScreen(id: list!.elementAt(index).id)));
          },
        );
      });
}

showToastMessage(message) {Fluttertoast.showToast(msg: message, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: BlackColor.withOpacity(0.9), textColor: Colors.white, fontSize: 14.0,);}


GestButton({String? buttontext, Function()? onclick, double? Width, double? height, Color? buttoncolor, EdgeInsets? margin, TextStyle? style,}) {
  return GestureDetector(
    onTap: onclick,
    child: Container(
      padding: EdgeInsets.all(16), alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CustomTheme.theamColor,
        boxShadow: [BoxShadow(color: CustomTheme.theamColor,
          offset: const Offset(0.5, 0.5,), blurRadius: 1,), //BoxShadow
        ],
      ),
      child: Text(buttontext!, style: style),
    ),
  );
}