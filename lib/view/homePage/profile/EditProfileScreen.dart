import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';

import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: notifire.getwhiteblackcolor,
              )),
          title: Text(
            'Edit Personal Info',
            style: TextStyle(
                fontSize: 17,
                fontFamily: FontStyles.gilroyBold,
                color: notifire.getwhiteblackcolor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        children: [
                          const Icon(Icons.account_circle_rounded,size: 120,),
                          Positioned(
                            bottom: 5,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: const Icon(Icons.edit, color: Colors.white),
                              // color: CustomTheme.theamColor,
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: CustomTheme.theamColor,
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "First Name",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                myWidget("First Name", "Please enter your first name",
                    TextEditingController()),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Last Name",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                myWidget("Last Name", "Please enter your last name",
                    TextEditingController()),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Mobile Phone",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                IntlPhoneField(
                  keyboardType: TextInputType.number,
                  cursorColor: notifire.getwhiteblackcolor,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  dropdownIcon: Icon(
                    Icons.arrow_drop_down,
                    color: notifire.getgreycolor,
                  ),
                  dropdownTextStyle: TextStyle(color: notifire.getgreycolor),
                  style: TextStyle(
                    fontFamily: "Gilroy",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: notifire.getwhiteblackcolor,
                  ),
                  onCountryChanged: (value) {
                  },
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: notifire.getgreycolor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: notifire.getgreycolor,
                      ),
                    ),
                    labelText: "Mobile Number".tr,
                    labelStyle: TextStyle(
                        color: notifire.getgreycolor,
                        fontWeight: FontWeight.w700),
                  ),
                  invalidNumberMessage: "please enter your mobile number".tr,
                ),
                const Text(
                  "Email",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                myWidget("Email", "Please enter your Email",
                    TextEditingController()),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  cursorColor: notifire.getwhiteblackcolor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: notifire.getwhiteblackcolor,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password'.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                          color: CustomTheme.theamColor, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greycolor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: greycolor,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: "Password".tr,
                    labelStyle: TextStyle(
                      color: notifire.getgreycolor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Birthday",
                  style: TextStyle(
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  cursorColor: notifire.getwhiteblackcolor,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: notifire.getwhiteblackcolor,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: CustomTheme.theamColor, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: CustomTheme.theamColor),
                    ),
                    labelText: "YYYY-MM-DD".tr,
                    labelStyle: TextStyle(
                        color: notifire.getgreycolor,
                        fontWeight: FontWeight.w700),
                  ),
                  validator: (value) {
                    print(value);
                    if (value == null || value.isEmpty) {
                      return 'Please enter Date of Birth'.tr;
                    }
                    return null;
                  },
                  onTap: () async {
                  },
                ),
                const SizedBox(height: 20,),
                GestButton(height: 50, buttoncolor: blueColor, buttontext: "Continue".tr, style: TextStyle(fontFamily: "Gilroy Bold", color: WhiteColor, fontSize: 16, fontWeight: FontWeight.bold,), onclick: () async {},),
              ],
            ),
          ),
        ));
  }

  myWidget(label, validationText, controller) {
    return TextFormField(
      controller: controller, keyboardType: TextInputType.name, cursorColor: notifire.getwhiteblackcolor, autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(fontFamily: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w600, color: notifire.getwhiteblackcolor,),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: CustomTheme.theamColor, width: 2),),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: CustomTheme.theamColor),),
        labelText: label,
        labelStyle: TextStyle(color: notifire.getgreycolor, fontWeight: FontWeight.w700),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationText;
        }
        return null;
      },
    );
  }
}
