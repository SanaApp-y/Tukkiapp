import 'package:bot_toast/bot_toast.dart';

import 'utils/DarkMode.dart';

var closeLoading;
String token="";
String latitudeGlobal='';
String longitudeGlobal='';
String firstName="";
String profileImage="";
late ColorNotifire notifire;

showLoading(){
  closeLoading=BotToast.showLoading();
}


