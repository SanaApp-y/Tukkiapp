import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/helper/RoutesHelper.dart';

import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/common_widgets.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/auth/loginScreen.dart';

import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.EditProfileScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: profileImage.isEmpty?Icon(Icons.account_circle_rounded,size: 50,)
                          // Image.asset("assets/images/profilephotojpg.jpg", height: 50,)
                              :SizedBox(height: 50,width: 50,child: Image.network(profileImage,errorBuilder: ( context,  exception,  stackTrace){
                                return Icon(Icons.account_circle_rounded,size: 50,);
                          },)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$firstName',
                                  style: CustomTheme.MainProfileScreenHeading,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Text(
                                  'view and edit profile',
                                  style: TextStyle(
                                    fontFamily: FontStyles.gilroyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                          color: notifire.getwhiteblackcolor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: CustomTheme.theamColor,
                  width: MediaQuery.of(context).size.width * 0.90,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Text(
                              'Hosting',
                              style: CustomTheme.MainProfileScreenHeading,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      settingWidget(
                        name: "Switch to traveling".tr,
                        imagePath: "assets/images/Work.png",
                        onTap: () {
                          print("hello");
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomTheme.theamColor,
                  width: MediaQuery.of(context).size.width * 0.90,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Account Setting',
                            style: CustomTheme.MainProfileScreenHeading,
                          ),
                        ],
                      ),
                    ),
                    settingWidget(
                      name: "Review".tr,
                      imagePath: "assets/images/Star.png",
                      onTap: () {},
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                    settingWidget(
                      name: "Setting".tr,
                      imagePath: "assets/images/Setting.png",
                      onTap: () {},
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                    settingWidget(
                      name: "Manage your Account".tr,
                      imagePath: "assets/images/Profile.png",
                      onTap: () {},
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                    settingWidget(
                      name: "About".tr,
                      imagePath: "assets/images/Danger Circle.png",
                      onTap: () {
                        Get.toNamed(Routes.aboutusscreen);
                      },
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            'Support',
                            style: CustomTheme.MainProfileScreenHeading,
                          ),
                        ],
                      ),
                    ),
                    settingWidget(
                      name: "Privacy Policy".tr,
                      imagePath: "assets/images/Shield Done.png",
                      onTap: () {
                        Get.toNamed(Routes.privacypolicyscreen);
                      },
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                    settingWidget(
                      name: "Get Help".tr,
                      imagePath: "assets/images/2 User.png",
                      onTap: () {
                        Get.toNamed(Routes.getHelpScreen);
                      },
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    ),
                    settingWidget(
                      name: "Give us Feedback".tr,
                      imagePath: "assets/images/Send.png",
                      onTap: () {
                        Get.toNamed(Routes.giveUsFeedBackScreen);
                      },
                    ),
                    Container(
                      height: 1,
                      color: CustomTheme.theamColor,
                      width: MediaQuery.of(context).size.width * 0.90,
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log Out',
                        style: CustomTheme.MainProfileScreenLogout,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset('assets/images/Logout.png')
                    ],
                  ),
                  onTap: () {
                    logoutSheet(context);
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future logoutSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Logout".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontStyles.gilroyBold,
                color: CustomTheme.theamColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: notifire.getgreycolor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to log out?".tr,
              style: TextStyle(
                fontFamily: FontStyles.gilroyMedium,
                fontSize: 16,
                color: notifire.getwhiteblackcolor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancle".tr,
                        style: TextStyle(
                          color: CustomTheme.theamColor,
                          fontFamily: FontStyles.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFeef4ff),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      setState(() async {
                        //  save('isLoginBack', true);
                        await prefs.remove('Firstuser');
                        await prefs.remove('Remember');
                        // getData.remove("UserLogin");
                        // getData.remove("countryId");
                        // getData.remove("countryName");
                        // getData.remove("currentIndex");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Yes, Remove".tr,
                        style: TextStyle(
                          color: WhiteColor,
                          fontFamily: FontStyles.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: CustomTheme.theamColor,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: notifire.getbgcolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

Widget settingWidget({Function()? onTap, String? name, String? imagePath}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 45,
      width: Get.size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Image.asset(
            imagePath ?? "",
            height: 35,
            width: 30,
            color: notifire.getwhiteblackcolor,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            name ?? "",
            style: TextStyle(
              fontFamily: FontStyles.gilroyMedium,
              fontSize: 16,
              color: notifire.getwhiteblackcolor,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 17,
            color: notifire.getwhiteblackcolor,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
  );
}