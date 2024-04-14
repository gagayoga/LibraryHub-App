import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF260534);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
        builder: (context, _) => Scaffold(
          body: Container(
            width: width,
            height: height,
            color: primary,
            child: Stack(
              children: [

                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Text(
                          'Selamat Datang di LibraryHub!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 35.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.white
                          ),
                          maxLines: 2,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
                        child: Text(
                          'Buku manapun, kapanpun Di “LibraryHub”,'
                              ' kebebasan membaca tak terbatas.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white
                          ),
                          maxLines: 2,
                        ),
                      ),

                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Image.asset(
                            'assets/images/onboarding/model_marsha.png',
                            height: 480.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
                    child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 5,
                                shadowColor: primary,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.10))),
                            onPressed: () => Get.offAllNamed(Routes.LOGIN),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary),
                            )
                        )
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
