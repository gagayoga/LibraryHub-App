import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:libraryhub_fitra/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 4300), ((){
      Get.offAllNamed(Routes.ONBOARDING);
    })
    );
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('SplashView'),
        //   centerTitle: true,
        // ),
        body: Container(
          // memberikan background color
          decoration: const BoxDecoration(
            color: Color(0xFF260534),
          ),
          child: Center(
            //  gambar logo splash screen
            child: Lottie.asset(
              'assets/images/splash/logo_libraryhub.json',
              width: MediaQuery.of(context).size.width,
              repeat: false
            ),
          ),
        )
    );
  }
}
