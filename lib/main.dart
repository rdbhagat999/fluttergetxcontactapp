import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttergetxcontactapp/helpers/app_translations.dart';
import 'package:fluttergetxcontactapp/routes.dart';
import 'package:get/get.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyContactsApp());
}

class MyContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslation(),
      locale: Get.locale, // Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      initialRoute: RootScreen.pageId,
      getPages: appPages,
    );
  }
}
