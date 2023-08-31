import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isChecked = false;
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
          ),
        ),
        title: Text(
          "Add Property".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontStyles.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 10,
                width: Get.size.width,
                color: Color.fromARGB(255, 241, 240, 240),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Price',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Description',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextFormField(
                          // controller: reviewSummaryController.note,
                          minLines: 12,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorColor: notifire.getwhiteblackcolor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "My issue is ...".tr,
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
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: greyColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Beds',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total Bathroom',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property sqft.',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Rating',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Total person Allowd?',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Type',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Loreum lpsum",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          'City, Country',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: FontStyles.gilroyMedium,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Loreum lpsum",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              propertyFacility(
                name: "TV".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Tv.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Wifi".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Wi-Fi.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Food".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Food.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Dryer".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Dryer.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Washing Machine".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Washing-Machine .png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Gym".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Zym.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Fridge".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Fridge.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Pet Allow".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Pet.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              propertyFacility(
                name: "Car Parking".tr,
                checkbox: "",
                onChanged: () {
                  // faqController.getFaqDataApi();
                  // Get.toNamed(Routes.faqScreen);
                },
                imagePath: "assets/images/Cars.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 1,
                  width: Get.size.width,
                  color: greyColor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          'Latitude',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: FontStyles.gilroyMedium,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        Text('Longtitude',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Loreum lpsum',
                                  hintStyle: TextStyle(
                                      // fontFamily: FontStyles.gilroyMedium
                                      ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: greyColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Loreum lpsum',
                                  hintStyle: TextStyle(
                                      // fontFamily: FontStyles.gilroyMedium
                                      ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: greyColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: greyColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Location2.png'),
                        Text(
                          'Click for Current Location',
                          style: TextStyle(fontFamily: FontStyles.gilroyMedium),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  height: 100,
                  width: Get.size.width,
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Image.asset('assets/images/Upload.png'),
                  ),
                  decoration: BoxDecoration(
                    color: notifire.getblackwhitecolor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: greyColor),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'property Status',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: FontStyles.gilroyMedium,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Container(
                          height: 50,
                          width: Get.size.width,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Select Property',
                                style: TextStyle(color: greyColor),
                              ),
                              Spacer(),
                              Image.asset(
                                'assets/images/Arrow - Down.png',
                                color: greyColor,
                                height: 40,
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: notifire.getblackwhitecolor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: greyColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestButton(
                Width: Get.size.width,
                height: 50,
                buttoncolor: blueColor,
                margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                buttontext: "Update".tr,
                style: TextStyle(
                  fontFamily: FontStyles.gilroyBold,
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () {
              
                },
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget propertyFacility(
      {Function()? onChanged,
      String? name,
      String? checkbox,
      String? imagePath}) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              // fillColor: MaterialStatePropertyAll(CustomTheme.theamColor),
              // fillColor: CustomTheme.theamColor,
              value: isChecked,
              shape: CircleBorder(),
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            SizedBox(
              width: 0,
            ),
            Text(
              name ?? "",
              style: TextStyle(
                fontSize: 15,
                fontFamily: FontStyles.gilroyMedium,
              ),
            ),
            Spacer(),
            Image.asset(
              imagePath ?? "",
              height: 30,
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}
