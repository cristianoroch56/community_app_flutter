import 'package:community_app/data/services/push_notification_services.dart';
import 'package:community_app/pages/auth/authentication_manager.dart';
import 'package:community_app/routes/app_pages.dart';
import 'package:community_app/pages/splash_screen.dart';
import 'package:community_app/translation/key.dart';
import 'package:community_app/widget/scroll_behavior.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'constants/style.dart';
import 'translation/reanslation.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final pushNotificationService = PushNotificationService();
  await pushNotificationService.initialize();

  SystemUiOverlayStyle.light;
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final auth = Get.put(AuthenticationManager());
  @override
  Widget build(BuildContext context) {
    String? localLanguage = auth.getLanguage() ?? 'en_US';
    print("localLanguage;$localLanguage");
    return GetMaterialApp(
      title: Tkey.appName.tr,
      translations: Language(),
      locale: localLanguage == "en_US"
          ? const Locale('en', 'US')
          : const Locale('gu', 'IN'),
      fallbackLocale: const Locale('en', 'US'),
      defaultTransition: Transition.fadeIn,
      getPages: routePages,
      theme: appThemeData[AppTheme.CustomTheme],
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      home: SplashScreen(),
    );
  }
}
