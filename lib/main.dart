import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:movies_app/pages/home_page.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/login_screen.dart';
import 'package:movies_app/pages/main_page.dart';
import 'package:movies_app/pages/details_page.dart';
import 'package:movies_app/pages/splash_page.dart';
import 'package:movies_app/themes/themes.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MovieApp',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/login1', page: () => const LoginScreen()),
        GetPage(name: '/main', page: () => const MainPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/deatils', page: () => const DetailsPage()),
      ],
    );
  }
}
