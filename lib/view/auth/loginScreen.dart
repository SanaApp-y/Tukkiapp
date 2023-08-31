import 'dart:convert';

import 'package:Tukki/config/Api.dart';
import 'package:Tukki/config/http_service.dart';
import 'package:Tukki/controller/LoginController.dart';
import 'package:Tukki/helper/FontstyleModel.dart';
import 'package:Tukki/helper/RoutesHelper.dart';
import 'package:Tukki/model/LoginModel.dart';
import 'package:Tukki/utils/customWidget.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/ProjectColors.dart';
import 'package:Tukki/utils/common_widgets.dart';
import 'package:Tukki/utils/custom_theme.dart';
import 'package:Tukki/view/auth/UserGoogleSignUpScreen.dart';
import 'package:Tukki/view/auth/UserSignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/DataStore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserloginController userloginController = Get.put(UserloginController());

  late ColorNotifire notifire;
  String cuntryCode = "";
  bool isChecked = false;


  TextEditingController textEditingControllerEmail =TextEditingController();
  TextEditingController textEditingControllerPass =TextEditingController();
  bool showPassword=true;




  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: notifire.getbgcolor,
        elevation: 0,centerTitle: false,
          title: InkWell(onTap: (){
            Get.to(()=>UserSignUpScreen());
          },
            child: Container(padding: const EdgeInsets.only(left: 16,right: 16,top: 2,bottom: 2),decoration:  BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: CustomTheme.theamColor)),child: const Row(mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios,color: CustomTheme.theamColor,),
                Text("Back",style: TextStyle(color: CustomTheme.theamColor,fontSize: 14,fontWeight: FontWeight.bold),),
              ],
            ),),
          ),
        // Image.asset('assets/images/BackButton.png'),

          actions: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        SizedBox(width: 16,)
      ]),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: CustomTheme.pagePadding,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Text(
                  "Welcome to Tukki".tr,
                  style: const TextStyle(
                      fontSize: 25,
                      fontFamily: FontStyles.gilroyBold,
                      color: CustomTheme.loginTopText),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Email".tr,
                  style: const TextStyle(
                      fontSize: 16, color: CustomTheme.theamColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),

                SizedBox(
                  child: TextFormField(
                    controller: textEditingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: notifire.getwhiteblackcolor,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: notifire.getwhiteblackcolor,
                    ),
                    decoration: InputDecoration(hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: CustomTheme.theamColor,
                            width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              width: 1, color: CustomTheme.theamColor)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: CustomTheme.theamColor),
                      ),
                    ),
                    validator: (value) {
                      if(!GetUtils.isEmail(value!)){
                        return 'Please enter Valid email'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16,),

                Text(
                  "Password".tr,
                  style: const TextStyle(
                      fontSize: 16, color: CustomTheme.theamColor,fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: textEditingControllerPass,
                    obscureText: showPassword,
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
                    decoration: InputDecoration(hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: CustomTheme.theamColor,width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                            width: 1, color: CustomTheme.theamColor)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: greycolor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),



                      suffixIcon: InkWell(
                        onTap: () {
                          if(showPassword){
                            showPassword=false;
                          }else{
                            showPassword=true;
                          }
                          setState(() {
                          });
                        },
                        child: !showPassword
                            ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/showpassowrd.png",
                            height: 10,
                            width: 10,
                            color: notifire.getgreycolor,
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/HidePassword.png",
                            height: 10,
                            width: 10,
                            color: notifire.getgreycolor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.resetPassword);
                  },
                  child: Text(
                    "Forget Password?".tr,
                    style: const TextStyle(
                        fontFamily: FontStyles.gilroyBold,
                        color: CustomTheme.theamColor,
                        fontSize: 16
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Container(
                  margin: CustomTheme.verticalPagePadding,
                  child: GestButton(
                    buttoncolor: blueColor,
                    buttontext: "Login".tr,
                    style: TextStyle(
                      fontFamily: "Gilroy Bold",
                      color: WhiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    onclick: () async {
                      try {

                        if (_formKey.currentState?.validate() ?? false) {
                          buildShowDialog(context);
                          var json=await httpPost(Config.userEmailLogin, {
                            "email": textEditingControllerEmail.text,
                            "password": textEditingControllerPass.text,
                            "phone_country": cuntryCode
                          });

                          Navigator.of(context, rootNavigator: true).pop();
                          LoginModel loginModel =LoginModel.fromJson(json);

                          if (loginModel.status==200) {
                            final pref = await SharedPreferences.getInstance();
                            await pref.setBool("Remember", true);
                            await pref.setBool("Firstuser", true);

                            UserData userObj = UserData();
                            userObj.saveLoginData("UserData", jsonEncode(json));

                            Get.toNamed(Routes.bottoBarScreen);
                          } else {
                            showToastMessage(loginModel.error!);
                          }
                        }
                      } catch(e) {
                        print(e);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "-------- or continue with --------".tr,
                    style: const TextStyle(
                      fontFamily: FontStyles.gilroyMedium,
                      fontSize: 16,
                      color: CustomTheme.theamColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CustomTheme.theamColor,
                        width: 2,
                      )),
                  // width: Get.width,
                  child: InkWell(
                    onTap: () {
                      methodCallGoogleLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Login with Google',
                          style: TextStyle(
                              fontSize: 15, color: CustomTheme.theamColor),
                        )
                      ],
                    ),
                  ),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: CustomTheme.theamColor,
                        width: 2,
                      )),
                  // width: Get.width,
                  child: InkWell(
                    onTap: () {
                      methodCallGoogleLogin();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/applelogo.png',
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Login with Apple',
                          style: TextStyle(
                              fontSize: 15, color: CustomTheme.theamColor),
                        )
                      ],
                    ),
                  ),
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                ),
                 Container(
                  height: Get.height * .13,
                  
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account? ".tr,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontStyles.gilroyMedium,
                          color: CustomTheme.theamColor,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.signUpScreen);
                      },
                      child: Text(
                        "Sign Up".tr,
                        style: const TextStyle(
                          color: CustomTheme.theamColor,
                          fontFamily: FontStyles.gilroyBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  methodCallGoogleLogin() async {
    print("googleLogin method Called");
    final _googleSignIn = GoogleSignIn();
    var result = await _googleSignIn.signIn();
    // var googleKey = await result!.authentication;
    //buildShowDialog(context);

    if (result!.email.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserGoogleSignUpScreen(
                  name: result.displayName.toString(),
                  email: result.email.toString(),
                  id: result.id.toString(),
                  photoUrl: result.photoUrl.toString())));
      // Get.toNamed(Routes.googleSignUpScreen(name:result.displayName,email:result.email,photoUrl:result.photoUrl));
    }
    // Navigator.of(context, rootNavigator: true).pop();
  }
}