import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:libraryhub_fitra/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';

import '../../../data/provider/storage_provider.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? statusUser = StorageProvider.read(StorageKey.status);

    Future.delayed(
        const Duration(milliseconds: 4300), ( (){
      if (statusUser == 'logged'){
        Get.offAllNamed(Routes.DASHBOARD);
      }else{
        Get.offAllNamed(Routes.ONBOARDING);
      }
    })
    );
    return Scaffold(
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
