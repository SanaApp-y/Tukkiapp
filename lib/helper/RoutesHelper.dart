import 'package:Tukki/view/addproperty/AddPropertyScreen.dart';
import 'package:Tukki/view/auth/ResetPasswordScreen.dart';
import 'package:Tukki/view/auth/loginScreen.dart';
import 'package:Tukki/view/auth/ChangePasswordScreen.dart';
import 'package:Tukki/view/auth/UserOtpSignUpScreen.dart';
import 'package:Tukki/view/auth/UserSignUpScreen.dart';
import 'package:Tukki/view/auth/UserGoogleSignUpScreen.dart';
import 'package:Tukki/view/homePage/HomePage.dart';
import 'package:Tukki/view/homePage/explore/PropertyDetailsScreen.dart';
import 'package:Tukki/view/homePage/profile/EditProfileScreen.dart';
import 'package:Tukki/view/homePage/profile/StaticPageScreen.dart';
import 'package:Tukki/view/splash/InitialScreen.dart';
import 'package:Tukki/view/splash/WelcomeScreen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static String initial = "/";
  static String welcome = "/WelcomeScreen";
  static String onBordingScreen = '/OnBordingScreen';
  static String login = "/Login";
  static String forgetPassword = "/ForgetPasswordScreen";
  static String changePassword = "/ChangePasswordScreen";
  static String bottoBarScreen = "/BottoBarScreen";
  static String signUpScreen = "/signUpScreen";
  static String googleSignUpScreen = "/UserGoogleSignUpScreen";
  static String otpScreen = '/otpScreen';
  static String resetPassword = "/resetPassword";
  static String viewDataScreen = "/viewDataScreen";
  static String massageScreen = "/massageScren";
  static String profileScreen = "/profileScreen";
  static String reviewScreen = "/reviewScreen";
  static String ourRecommendationScreen = "/ourRecommendationScreen";
  static String notificationScreen = "/notificationScreen";
  static String homeSearchScreen = "/homeSearchScreen";
  static String bookingScreen = "/bookingScreen";
  static String languageScreen = "/languageScreen";
  static String viewProfileScreen = "/viewProfileScreen";
  static String bookRealEstate = "/bookRealEstate";
  static String bookInformetionScreen = "/bookInformetionScreen";
  static String reviewSummaryScreen = "/reviewSummaryScreen";
  static String couponsScreen = "/couponsScreen";
  static String eReceiptScreen = "/eReceiptScreen";
  static String loreamScreen = "/loreamScreen";
  static String faqScreen = "/faqScreen";
  static String walletScreen = "/walletScreen";
  static String addWalletScreen = "/addWalletScreen";
  static String referFriendScreen = "/referFriendScreen";
  static String featuredScreen = "/featuredScreen";
  static String addPropertiesOne = "/addPropertiesOne";
  static String selectCountryScreen = "/selectCountryScreen";
  static String mostviewedScreen = "/mostviewedScreen";
  static String RecommendedScreen = "/RecommendedScreen";
  static String propertyprofileScreen = "/propertyprofileScreen";
  static String userOtpSignUpScreen = "/userOtpSignUpScreen";
  static String addPropertyScreen = "/addpropertyscreen";
  static String giveUsFeedBackScreen = "/giveUsFeedBackScreen";
  static String getHelpScreen = "/getHelpScreen";
  static String privacypolicyscreen = "/privacypolicyscreen";
  static String aboutusscreen = "/aboutusscreen";
  static String conversationScreen = "/conversationScreen";
  static String EditProfileScreen = "/EditProfileScreen";
}

final getPages = [
  GetPage(
    name: Routes.initial,
    page: () => InitialScreen(),
  ),
  GetPage(
    name: Routes.welcome,
    page: () => WelcomeScreen(),
  ),
  GetPage(
    name: Routes.login,
    page: () => const LoginScreen(),
  ),

  GetPage(
    name: Routes.changePassword,
    page: () => ChangePasswordScreen(email: "",resetToken: ""),
  ),
  GetPage(
    name: Routes.bottoBarScreen,
    page: () =>  HomePage(initialIndex: 0,),
  ),
  GetPage(
    name: Routes.signUpScreen,
    page: () => UserSignUpScreen(),
  ),

  GetPage(
    name: Routes.googleSignUpScreen,
    page: () =>
        const UserGoogleSignUpScreen(name: '', email: '', id: '', photoUrl: ''),
  ),
  GetPage(
    name: Routes.userOtpSignUpScreen,
    page: () => const UserOtpSignUpScreen(number: '', countryCode: '',otpValue: "",email: "",),
  ),
  GetPage(
    name: Routes.resetPassword,
    page: () => const ResetPasswordScreen(),
  ),
  GetPage(
    name: Routes.propertyprofileScreen,
    page: () => PropertyDetailsScreen(id: ''),
  ),
  GetPage(
    name: Routes.addPropertyScreen,
    page: () => AddPropertyScreen(),
  ),

  GetPage(
    name: Routes.EditProfileScreen,
    page: () => EditProfileScreen(),
  ),

  GetPage(
    name: Routes.giveUsFeedBackScreen,
    page: () => StaticPage(data: "Give us feedback",),
  ),
  GetPage(
    name: Routes.getHelpScreen,
    page: () =>StaticPage(data: "Get help",),
  ),
  GetPage(
    name: Routes.privacypolicyscreen,
    page: () => StaticPage(data: "Privacy policy",),
  ),
  GetPage(
    name: Routes.aboutusscreen,
    page: () => StaticPage(data: "About us",),
  )
];
