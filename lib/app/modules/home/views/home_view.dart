import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/components/customImageCarousel.dart';
import 'package:libraryhub_fitra/app/components/customListBukuRekomendasi.dart';
import 'package:libraryhub_fitra/app/data/provider/storage_provider.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    const Color background = Color(0xFF260534);

    String usernameUser = StorageProvider.read(StorageKey.username);

    // Ucapan selamat
    var jam = DateTime.now().hour;

    String ucapan;

    if(jam >= 1 && jam <= 11){
      ucapan = "Selamat Pagi";
    }else if(jam >= 11 && jam < 15){
      ucapan = "Selamat Siang";
    }else if(jam >= 15 && jam < 18){
      ucapan = "Selamat Sore☀️";
    }else {
      ucapan = "Selamat Malam🌙";
    }

    return ScreenUtilInit(
      builder: (context, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFFFF),
            automaticallyImplyLeading: false,
            toolbarHeight: 60.0,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/profile.png',
                        height: 50,
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 10.w,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        'Hallo $usernameUser',
                        minFontSize: 14,
                        maxFontSize: 20,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: background,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                      AutoSizeText(
                        ucapan,
                        textAlign: TextAlign.start,
                        minFontSize: 14,
                        maxFontSize: 18,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              width: width,
              height: height,
              color: background,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const CustomImageCarousel(),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                'Buku Populer',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),

                              AutoSizeText(
                                'Lihat Semua>',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomListRekomendasiBuku(context: Get.context!),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                'Buku Populer',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),

                              AutoSizeText(
                                'Lihat Semua>',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomListRekomendasiBuku(context: Get.context!),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                'Buku Populer',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),

                              AutoSizeText(
                                'Lihat Semua>',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomListRekomendasiBuku(context: Get.context!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
