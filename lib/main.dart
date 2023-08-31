import 'package:Tukki/helper/RoutesHelper.dart';
import 'package:Tukki/utils/DarkMode.dart';
import 'package:Tukki/utils/LocalStirng.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'helper/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifire(),
        ),
      ],
      child: GetMaterialApp(
        builder:BotToastInit(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Gilroy"),
          translations: LocaleString(),
          locale: const Locale('en_US', 'en_US'),
          getPages: getPages,
          initialRoute: Routes.initial,
          fallbackLocale: Locale('en_us', 'en_us')
          ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        
        //  home: InitialScreen()
        );
  }
}
