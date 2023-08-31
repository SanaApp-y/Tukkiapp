import 'dart:convert';
import 'package:Tukki/controller/LoginController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/model/LoginModel.dart';
import 'package:Tukki/model/ResetPassModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/common_widgets.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/auth/ChangePasswordScreen.dart';
import 'package:Tukki/view/homePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../config/DataStore.dart';
import '../../workspace.dart';

class UserOtpSignUpScreen extends StatefulWidget {
  final String number;
  final String countryCode;
  final String otpValue;
  final String email;
  const UserOtpSignUpScreen(
      {super.key,
      required this.number,
      required this.countryCode,
      required this.otpValue,
      required this.email});

  @override
  State<UserOtpSignUpScreen> createState() => _UserOtpSignUpScreenState();
}

class _UserOtpSignUpScreenState extends State<UserOtpSignUpScreen> {
  UserloginController controller=Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  OtpFieldController textEditingController = OtpFieldController();
  late ColorNotifire notifire;

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 1),(){
      print("called");
      textEditingController.set(widget.otpValue.split(""));
    },);
  }

  resendNewCodeFunction() async {
    controller.isResendLoading.value = true;
    if (widget.email.isEmpty) {
      var result = await controller.resendOtp(
          {"phone": widget.number, "phone_country": widget.countryCode});
    } else {
      var resultToken = await controller.resendToken({"email": widget.email});
    }
    controller.isResendLoading.value = false;
  }

  verifyFunction(otp) async {


    showLoading();

    if (widget.email.isEmpty) {
      var result = await controller.verifyOtp({
        "phone": widget.number,
        "otp_value": otp,
        "phone_country": widget.countryCode
      });

      closeLoading();

      LoginModel loginModel = LoginModel.fromJson(result);
      if (loginModel.status == 200) {
        showToastMessage(loginModel.message);
        UserData userObj = UserData();
        userObj.saveLoginData("UserData", jsonEncode(result));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => HomePage(initialIndex: 0)));
      } else {
        showToastMessage(loginModel.error);
        textEditingController.clear();
      }
      print(result);
    } else {
      var response = await controller.verifyResetToken(
          {"email": widget.email, "reset_token": otp});
      closeLoading();
      ResetPassModel resetPassModel = ResetPassModel.fromJson(response);
      if (resetPassModel.status == 200) {
        showToastMessage(resetPassModel.message);
        UserData userObj = UserData();
        userObj.saveLoginData("UserData", jsonEncode(response));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => ChangePasswordScreen(
                      email: widget.email,
                      resetToken: otp,
                    )));
      } else {
        showToastMessage(resetPassModel.error);
        textEditingController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: createAppBar("", () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        padding: CustomTheme.pagePadding,
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Verification Code".tr,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: FontStyles.gilroyBold,
                    color: CustomTheme.theamColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "We have sent the code verification to"
                    .tr,
                // "${"We have sent the code verification to".tr} ,
                // \n${countryCode} ${phoneNumber}",
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: FontStyles.gilroyMedium,
                  color: BlackColor,
                ),
              ),
              SizedBox(height: 8,),
              Text(
                "${widget.email}${widget.countryCode} ${widget.number}"
                    .tr,
                // "${"We have sent the code verification to".tr} ,
                // \n${countryCode} ${phoneNumber}",
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: FontStyles.gilroyMedium,
                  color: BlackColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?".tr,
                      style: TextStyle(
                        fontFamily: FontStyles.gilroyMedium,
                        color: BlackColor,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Obx(
                      () => controller.isResendLoading.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator())
                          : InkWell(
                              onTap: () async {
                                // sendOTP(phoneNumber, countryCode);
                                resendNewCodeFunction();
                              },
                              child: Text(
                                "Resend New Code".tr,
                                style: TextStyle(
                                  color: CustomTheme.theamColor,
                                  fontFamily: FontStyles.gilroyBold,
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "Enter OTP".tr,
                style: TextStyle(
                  fontFamily: FontStyles.gilroyMedium,
                  color: BlackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 32,),
              OTPTextField(
                controller: textEditingController,
                  length: 4,
                  width: MediaQuery.of(context).size.width-80,
                  textFieldAlignment: MainAxisAlignment.spaceEvenly,
                  fieldWidth: 55,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10,
                  style: TextStyle(fontSize: 17),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    verifyFunction(pin);
                  }),
              // Container(
              //   margin: CustomTheme.verticalPagePadding,
              //   child: TextFormField(
              //     // controller: textEditingController,
              //     cursorColor: notifire.getwhiteblackcolor,
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     style: TextStyle(
              //       fontFamily: 'Gilroy',
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       color: notifire.getwhiteblackcolor,
              //     ),
              //     decoration: InputDecoration(
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15),
              //         borderSide: BorderSide(color: notifire.getgreycolor),
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       prefixIcon: Padding(
              //         padding: const EdgeInsets.all(10),
              //       ),
              //       labelText: "",
              //       labelStyle: TextStyle(
              //         color: notifire.getgreycolor,
              //       ),
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Please enter otp'.tr;
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              // Container(
              //   margin: CustomTheme.verticalPagePadding,
              //   child: GestButton(
              //     Width: Get.size.width,
              //     height: 50,
              //     buttoncolor: blueColor,
              //     margin: EdgeInsets.only(top: 15, left: 30, right: 30),
              //     buttontext: "Verify".tr,
              //     style: TextStyle(
              //       fontFamily: "Gilroy Bold",
              //       color: WhiteColor,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     onclick: () {
              //       // Get.toNamed(Routes.bottoBarScreen);
              //       verifyFunction();
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
