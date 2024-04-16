
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void loadLogin() {
    Timer(const Duration(seconds: 2), () {
      Get.toNamed('/login1');
    });
  }

  @override
  void initState() {
    super.initState();
    loadLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/moviesp.png',
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}
