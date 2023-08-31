import 'package:Tukki/controller/BookrealEstateController.dart';
import 'package:Tukki/controller/GeneralController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/PropertyDetailsModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';

import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/booking/webviewpage.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../homePage/HomePage.dart';

class ReviewSummary extends StatefulWidget {
  final dynamic idFeatured;

  final dynamic numberofguest;
  final dynamic bookingForSomeOne;
  int totalNight;
  PropertyDetails propertyDetails;

  ReviewSummary(
      {super.key,
      required this.idFeatured,
      required this.numberofguest,
      required this.bookingForSomeOne,
      required this.totalNight,
      required this.propertyDetails});

  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  BookRealEstateController bookRealEstateController = Get.find();
  PageController _pageControllerslider = PageController();
  final ValueNotifier<int> _currentPageSliderNotifier = ValueNotifier<int>(0);
  TextEditingController textEditingController = TextEditingController();

  var couponValue;
  double basePrice=0;
  double tax=0;
  double serviceCharge=0;
  String currency="";
  double discount=0;
  bool isPaymentSuccess=false;

  @override
  void initState() {
    super.initState();
    _pageControllerslider = PageController();
    _pageControllerslider.addListener(() {
      if (_pageControllerslider.page != null) {
        _currentPageSliderNotifier.value = _pageControllerslider.page!.round();
      }
    });
    textEditingController.addListener(listner);

    basePrice=double.parse("${widget.propertyDetails.price}") * double.parse("${widget.totalNight}");
    currency=generalDataModel!.data!.metaData!.generalDefaultCurrency!;
    tax=basePrice*double.parse(generalDataModel!.data!.metaData!.feesetupIvaTax!)/100;
    serviceCharge=basePrice*double.parse(generalDataModel!.data!.metaData!.feesetupGuestServiceCharge!)/100;
  }

  listner() {
    if (textEditingController.text.isNotEmpty) {
      bookRealEstateController.showAddCouponBtn.value = true;
    } else {
      bookRealEstateController.showAddCouponBtn.value = false;
    }
  }

    bookProperty() async {

    showLoading();

    var total=basePrice-discount+  serviceCharge+tax;
    var result=await bookRealEstateController.bookPropertyMethod("${widget.propertyDetails.propertyId}", bookRealEstateController.startDate.value, bookRealEstateController.endDate.value, "${widget.totalNight}", "${widget.propertyDetails.price}",  widget.bookingForSomeOne, "$basePrice", "$serviceCharge", "0", "$tax", '$total', currency, 'stripe', '0', widget.propertyDetails.hostId!);
    closeLoading();
    if(result!=null){
      if(result['data']!=null){
        Get.to(()=>WebViewPage(url: result['data']['payment_url'],bookingId: result['data']['booking_id'].toString(),))!.then((value)
        {
          if(value==null){
            return;
          }
          Fluttertoast.showToast(msg: value=="NotPaid"?"Payment Failed":"Payment Successful");
          if(value=="NotPaid"){
            isPaymentSuccess=false;
          }else{
            isPaymentSuccess=true;
          }
          setState(() {
          });
        });
      }
    }
  }


  checkCouponMethod()async{
    couponValue=await bookRealEstateController.checkCouponMethod({"coupon_code":textEditingController.text});
    if(couponValue!=null){
      print("dissssssss1");
      print(double.parse('${couponValue['min_order_amount']}'));
      print(basePrice);
      
      if(double.parse('${couponValue['min_order_amount']}')<basePrice){
        print("dissssssss2");
        discount=basePrice* double.parse('${couponValue["coupon_value"]}')/100;
        Fluttertoast.showToast(msg: "Coupon added");
      }else{
        Fluttertoast.showToast(msg: "Min order amount is less than required for coupon");
      }
      textEditingController.text="";
      setState(() {
      });
    }
  }

  @override
  void dispose() {
    _pageControllerslider.dispose();
    textEditingController.removeListener(listner);

    super.dispose();
  }

  onWillPop(){
    if(isPaymentSuccess==false){
      return true;
    }else{
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {

    notifire = Provider.of<ColorNotifire>(context, listen: true);

    return
        WillPopScope(onWillPop: ()=> onWillPop(),child:
        Scaffold(
          backgroundColor: notifire.getbgcolor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: notifire.getbgcolor,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  if(isPaymentSuccess==false){
                    Get.back();
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: notifire.getwhiteblackcolor,
                )),
            title: Text(
              isPaymentSuccess==false?'Review Summary':"Booking Summary",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontStyles.gilroyBold,
                  color: notifire.getwhiteblackcolor),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: Get.size.width,
                            height: 200,
                            child: ListView.builder(
                                controller: _pageControllerslider,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.propertyDetails.galleryImageUrls!.length,
                                itemBuilder: (context, index) {
                                  return FadeInImage.assetNetwork(
                                    fadeInCurve: Curves.easeInCirc,
                                    placeholder:
                                    "assets/images/ezgif.com-crop.gif",
                                    height: 200,
                                    width: Get.size.width,
                                    image: widget.propertyDetails.galleryImageUrls!.elementAt(index) ,
                                    fit: BoxFit.cover,
                                  );
                                }),
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: _currentPageSliderNotifier,
                            builder: (context, value, child) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      widget.propertyDetails.galleryImageUrls!.length, (index) {
                                    return Container(
                                      margin:
                                      EdgeInsets.only(top: 200, left: 5),
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
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(widget.propertyDetails.price!,
                                    style: CustomTheme.featuredslidertitle),
                                Text('/night',
                                    style: CustomTheme.mostviewnight),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: CustomTheme.theamColor,
                              ),
                              Text(
                                  widget.propertyDetails.propertyRating!,
                                  style: CustomTheme.mostviewrating)
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.propertyDetails.title!,
                                style: CustomTheme.mostviewdescription,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "${widget.propertyDetails.propertyType!} Beds ${widget.propertyDetails.beds!} ",
                              style: CustomTheme.mostviewbeds,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Check in",
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyMedium,
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      Obx(
                            () => Text(
                          '${bookRealEstateController.startDate}',
                          style: TextStyle(
                            fontFamily: FontStyles.gilroyBold,
                            fontSize: 15,
                            color: CustomTheme.theamColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Check out",
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyMedium,
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      Obx(
                            () => Text(
                          '${bookRealEstateController.endDate}',
                          style: TextStyle(
                            fontFamily: FontStyles.gilroyBold,
                            fontSize: 15,
                            color: CustomTheme.theamColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Number of Guest",
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyMedium,
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      Text(
                        widget.numberofguest,
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyBold,
                          fontSize: 15,
                          color: CustomTheme.theamColor,
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Booking for someone",
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyMedium,
                          fontSize: 15,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      Text(
                        widget.bookingForSomeOne.isEmpty?'N/A':widget.bookingForSomeOne,
                        style: TextStyle(
                          fontFamily: FontStyles.gilroyBold,
                          fontSize: 15,
                          color: CustomTheme.theamColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  isPaymentSuccess==true?SizedBox():Visibility(
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Coupon",
                            style: TextStyle(
                              color: notifire.getwhiteblackcolor,
                              fontFamily: FontStyles.gilroyBold,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 40,
                            width: Get.size.width,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'assets/images/coupon.png',
                                  height: 25,
                                  width: 25,
                                  color: notifire.getgreycolor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: textEditingController,
                                    decoration: InputDecoration.collapsed(hintText: "coupon code",),
                                    style: TextStyle(
                                      fontFamily: FontStyles.gilroyMedium,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Spacer(),

                                Obx(() => bookRealEstateController.showAddCouponBtn.value==false?SizedBox():InkWell(
                                  onTap: () async {
                                    checkCouponMethod();
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      fontFamily: FontStyles.gilroyBold,
                                      fontSize: 16,
                                      color: CustomTheme.theamColor,
                                    ),
                                  ),
                                )),

                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: notifire.getblackwhitecolor,
                              borderRadius: BorderRadius.circular(15),
                              border:
                              Border.all(color: CustomTheme.theamColor, width: 2),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  rowX("Amount ( ${widget.totalNight} days )","$currency ${basePrice.toStringAsFixed(2)}"),
                  SizedBox(
                    height: 16,
                  ),
                  rowX("Tax ( ${generalDataModel!.data!.metaData!.feesetupIvaTax}% )","${currency} ${tax.toStringAsFixed(2)}"),
                  SizedBox(
                    height: 16,
                  ),
                  rowX("Service charge ( ${generalDataModel!.data!.metaData!.feesetupGuestServiceCharge}% )","$currency ${serviceCharge.toStringAsFixed(2)}"),
                  SizedBox(
                    height: 16,
                  ),
                  discount==0?SizedBox():rowX("Discount ( ${couponValue['coupon_value']}% )","$currency ${discount.toStringAsFixed(2)}"),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(thickness: 2,color: CustomTheme.theamColor,),

                  SizedBox(
                    height: 16,
                  ),
                  rowX("Total", couponValue==null?"$currency ${double.parse('${basePrice+serviceCharge+tax}').toStringAsFixed(2)}": "$currency ${double.parse('${basePrice + serviceCharge+tax   -discount}').toStringAsFixed(2) }",),


                  Container(
                    margin: CustomTheme.verticalPagePadding,
                    child: GestButton(
                      height: 50,
                      buttoncolor: blueColor,
                      buttontext: isPaymentSuccess==false? "Continue":"See my bookings",
                      style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        color: WhiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      onclick: () async {
                        if(isPaymentSuccess==false){
                          bookProperty();
                          // _showBottomSheet(context);
                          return;
                        }
                        generalController.currentIndex.value=2;
                        Get.offAll(()=>HomePage(initialIndex: 2,));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ), );
  }

  rowX(f1,f2){
    return  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(f1, style: TextStyle(
            fontFamily: FontStyles.gilroyMedium,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: notifire.getwhiteblackcolor,
          ),
        ),
        Text(
          f2,
          style: TextStyle(
            fontFamily: FontStyles.gilroyMedium,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: CustomTheme.theamColor,
          ),
        ),
      ],
    );
  }
  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //         child: Container(
  //             height: 500,
  //             color: Colors.white,
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 15,
  //                 ),
  //                 Container(
  //                   color: CustomTheme.theamColor,
  //                   width: 100,
  //                   height: 6,
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Container(
  //                   child: Text(
  //                     "Select Payment Method",
  //                     style: TextStyle(fontSize: 20),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Wrap(
  //                   spacing: 8.0, // gap between adjacent chips
  //                   runSpacing: 4.0, // gap between lines
  //                   children: <Widget>[
  //                     InkWell(onTap: (){
  //                       Navigator.pop(context);
  //                       bookProperty();
  //                     },
  //                       child: Container(
  //                         height: 130,
  //                         width: 85,
  //                         child: Column(
  //                           children: [
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             Container(
  //                               child: ClipRRect(
  //                                   child: Image.asset(
  //                                 'assets/images/Orange-Money-logo 2.png',
  //                                 height: 50,
  //                                 width: 50,
  //                               )),
  //                               decoration: BoxDecoration(
  //                                 border: Border.all(color: greyColor),
  //                                 borderRadius: BorderRadius.circular(100),
  //                               ),
  //                             ),
  //                             Text(
  //                               'Orange Money!',
  //                               textAlign: TextAlign.center,
  //                               style: TextStyle(fontSize: 15),
  //                             ),
  //                             Container(
  //                               height: 25,
  //                               width: 25,
  //                               child: Checkbox(
  //                                 value: true,
  //                                 side: const BorderSide(
  //                                     color: Color.fromARGB(255, 103, 104, 105)),
  //                                 activeColor: CustomTheme.theamColor,
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(5),
  //                                 ),
  //                                 onChanged: (newbool) {},
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         decoration: BoxDecoration(
  //                           color: notifire.getblackwhitecolor,
  //                           borderRadius: BorderRadius.circular(15),
  //                           border: Border.all(color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/Wave 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             'Wave',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 // borderRadius: BorderRadius.circular(50.0),
  //                                 child: Image.asset(
  //                               'assets/images/Visa_Logo 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             'Visa',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/free 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Free Money',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 16),
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/mastercard 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Master Card',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/moov 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Moov Money',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/Mask group.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             'MTN',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/e-money 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             'E-Money',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/wizall 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Wizal Money',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     ),
  //                     Container(
  //                       height: 130,
  //                       width: 85,
  //                       child: Column(
  //                         children: [
  //                           SizedBox(
  //                             height: 10,
  //                           ),
  //                           Container(
  //                             child: ClipRRect(
  //                                 child: Image.asset(
  //                               'assets/images/tmoney 1.png',
  //                               height: 50,
  //                               width: 50,
  //                             )),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(color: greyColor),
  //                               borderRadius: BorderRadius.circular(100),
  //                             ),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Text(
  //                             'T-Money',
  //                             textAlign: TextAlign.center,
  //                             style: TextStyle(fontSize: 15),
  //                           ),
  //                           SizedBox(
  //                             height: 5,
  //                           ),
  //                           Container(
  //                             height: 25,
  //                             width: 25,
  //                             child: Checkbox(
  //                               value: true,
  //                               side: const BorderSide(
  //                                   color: Color.fromARGB(255, 103, 104, 105)),
  //                               activeColor: CustomTheme.theamColor,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               onChanged: (newbool) {},
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       decoration: BoxDecoration(
  //                         color: notifire.getblackwhitecolor,
  //                         borderRadius: BorderRadius.circular(15),
  //                         border: Border.all(color: Colors.black),
  //                       ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             )),
  //       );
  //     },
  //   );
  // }
}
