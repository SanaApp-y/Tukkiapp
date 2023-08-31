import 'package:Tukki/controller/BookrealEstateController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/BookDateRealEstate.dart';
import 'package:Tukki/model/PropertyDetailsModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';

import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/booking/ReviewSummary.dart';
import 'package:Tukki/workspace.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BookRealEstate extends StatefulWidget {
  final dynamic idFeatured;
  PropertyDetails propertyDetails;
 BookRealEstate({super.key, required this.idFeatured,required this.propertyDetails});

  @override
  State<BookRealEstate> createState() => _BookRealEstateState();
}

class _BookRealEstateState extends State<BookRealEstate> {
  int Numberofguest = 1;
  bool chack = false;

  String te = '';
  String EndDate = '';

  int count = 1;
  List<DateTime> selectedDates = [];
  String checkDateResult = "true";
  String checkDateMsg = "";
  bool _isChecked = false;
  String rangeCount = '';
  bool visible = false;

  final TextEditingController _textController = TextEditingController();
  List days = [];
  // PropertyProfileScreenController featchprofileList = Get.find();
  BookRealEstateController bookrealEstateController = Get.find();
  late Future<BookdDate> bookedDateFuture;
  List<DateTime> alreadySelectedList = [];
  bool processing = true;

  checkTermsAndCondition(bool? newbool) {
    chack = newbool ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    bookrealEstateController.idFeatured = widget.idFeatured;
    getData();
  }



  getData() async {
    BookdDate bookdDate = await bookrealEstateController.bookDateApi(idFeatured: '${widget.idFeatured}');

    print(bookdDate.data!.propertyBookingDate);
    for (int i = 0; i < bookdDate.data!.propertyBookingDate!.length; i++) {
      List<DateTime> daysx = getDaysInBetween(
          DateTime.tryParse(bookdDate.data!.propertyBookingDate![i].checkIn!)!,
          DateTime.tryParse(
              bookdDate.data!.propertyBookingDate![i].checkOut!)!);
      alreadySelectedList.addAll(daysx);
    }
    processing = false;
    setState(() {});
  }

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    print("DAYSSSSS $days");
    return days;
  }

  


  @override
  void dispose() {

    bookrealEstateController.startDate.value='';
    bookrealEstateController.endDate.value='';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);

    return Scaffold(
      backgroundColor: notifire.getbgcolor,
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
            )),
        title: Text(
          'Book Real Estate',
          style: TextStyle(
              fontSize: 17,
              fontFamily: FontStyles.gilroyBold,
              color: notifire.getwhiteblackcolor),
        ),
      ),
      body: processing
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Select Date",
                        style: TextStyle(
                            fontSize: 17, color: notifire.getwhiteblackcolor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(238, 233, 216, 178),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SfDateRangePicker(
                          controller: bookrealEstateController.controller,
                          onSelectionChanged:
                              bookrealEstateController.onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.range,
                          enablePastDates: false,
                          // rangeSelectionColor: Colors.red,
                          // startRangeSelectionColor:
                          //     bookrealEstateController.checkDateResult == "true"
                          //         ? blueColor
                          //         : RedColor,
                          // endRangeSelectionColor:
                          //     bookrealEstateController.checkDateResult == "true"
                          //         ? blueColor
                          //         : RedColor,
                          headerStyle: DateRangePickerHeaderStyle(
                            textStyle: TextStyle(
                              fontFamily: FontStyles.gilroyBlack,
                              color: notifire.getwhiteblackcolor,
                            ),
                          ),
                          monthViewSettings: DateRangePickerMonthViewSettings(
                            blackoutDates: alreadySelectedList,
                          ),
                          monthCellStyle: DateRangePickerMonthCellStyle(blackoutDateTextStyle: TextStyle(color: Colors.white,),blackoutDatesDecoration: BoxDecoration(shape: BoxShape.circle,color: Colors.redAccent.shade100)),

                          // initialSelectedRange: PickerDateRange(
                          //   DateTime.now().subtract(
                          //     Duration(days: 0),
                          //   ),
                          //   DateTime.now().add(
                          //     const Duration(days: 0),
                          //   ),
                          // ),
                        ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check in",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontStyles.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check out",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontStyles.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Obx(() => Text(
                                '${bookrealEstateController.startDate}',
                                style: TextStyle(
                                  fontFamily: FontStyles.gilroyMedium,
                                  color: notifire.getwhiteblackcolor,
                                ),
                              )),
                          Spacer(),
                          Image.asset(
                            "assets/images/Calendar.png",
                            height: 25,
                            width: 25,
                            color: BlackColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),

                          Obx(() => Text(
                                '${bookrealEstateController.endDate}',
                                style: TextStyle(
                                  fontFamily: FontStyles.gilroyMedium,
                                  color: notifire.getwhiteblackcolor,
                                ),
                              )),

                          //  Text(
                          //     "dd/mm/yyyy",
                          //     style: TextStyle(
                          //       fontFamily: FontStyles.gilroyMedium,
                          //       color: notifire.getgreycolor,
                          //     ),
                          //   ),
                          Spacer(),
                          Image.asset(
                            "assets/images/Calendar.png",
                            height: 25,
                            width: 25,
                            color: BlackColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: Get.size.width,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Number of Guest",
                              style: TextStyle(
                                color: notifire.getwhiteblackcolor,
                                fontFamily: FontStyles.gilroyBold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${"Allowd Max"} ${widget.propertyDetails.personAllowed!} ${"Guest"}",
                              style: TextStyle(
                                color: notifire.getwhiteblackcolor,
                                fontFamily: FontStyles.gilroyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (Numberofguest > 1)
                                    Numberofguest = Numberofguest - 1;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.remove,
                                  color: CustomTheme.theamColor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: CustomTheme.theamColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "$Numberofguest",
                                  // "${bookrealEstateController.count}",
                                  style: TextStyle(
                                      color: notifire.getwhiteblackcolor,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (Numberofguest < int.parse(widget.propertyDetails.personAllowed!))
                                    Numberofguest = Numberofguest + 1;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: CustomTheme.theamColor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: CustomTheme.theamColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Row(
                  children: [
                    Text(
                      "Note to Owner (optional)",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: FontStyles.gilroyBold,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: notifire.getwhiteblackcolor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Notes",
                    hintStyle: TextStyle(
                      fontFamily: FontStyles.gilroyMedium,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: FontStyles.gilroyMedium,
                    fontSize: 16,
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color.fromARGB(255, 125, 123, 123)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Booking for someone",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: FontStyles.gilroyBold,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                  Spacer(),
                  Transform.scale(
                    scale: 1,
                    child: InkWell(
                      child: Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                          if (value!) {
                            print('xyz');
                            Future.delayed(Duration(milliseconds: 50))
                                .then((value) {
                              Scrollable.ensureVisible(
                                  GlobalObjectKey(1).currentContext!);
                            });
                          }
                        },
                      ),
                      onTap: () {
                        print("hello jii");
                      },
                    ),
                  ),
                ],
              ),

              if (_isChecked)
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TextField(
                    key: GlobalObjectKey(1),
                    controller: _textController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getgreycolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: notifire.getgreycolor),
                      ),
                      labelText: "Name of guest",
                      labelStyle: TextStyle(
                        color: BlackColor,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 0,
          child:Obx(() =>           bookrealEstateController.isDateChecking.value==true?
          Center(child: Container(padding: EdgeInsets.all(8),decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: CustomTheme.theamColor),child: CircularProgressIndicator(color: Colors.white,))) :
          GestButton(
            Width: Get.size.width,
            height: 50,
            buttoncolor: blueColor,
            margin: EdgeInsets.only(top: 15, left: 30, right: 30),
            buttontext: "Continue",
            style: TextStyle(
              fontFamily: FontStyles.gilroyBold,
              color: WhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            onclick: () {
              chack == true;
              if(bookrealEstateController.startDate.value.isEmpty || bookrealEstateController.endDate.value.isEmpty){
                Fluttertoast.showToast(msg: 'Select date to continue');
                return;
              }
              if(bookrealEstateController.isDateAvailale==false){
                Fluttertoast.showToast(msg: 'Date is not available, try again.');
                return;
              }
              List totalNight=getDaysInBetween(
                  DateTime.tryParse(bookrealEstateController.startDate.value)!,
                  DateTime.tryParse(bookrealEstateController.endDate.value)!);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewSummary(
                    idFeatured: widget.idFeatured,
                    numberofguest: Numberofguest.toString(),
                    bookingForSomeOne: _textController.text,
                    totalNight: totalNight.length,
                    propertyDetails: widget.propertyDetails,
                  ),
                ),
              );
            },
          )),
        )
      ]),
    );
  }

  void open() {}
}
