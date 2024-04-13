import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/provider/storage_provider.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color background =  Color(0xFF260534);

    double toolbar = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double bodyHeight = height - toolbar - 60;


    return ScreenUtilInit(
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          automaticallyImplyLeading: false,
          toolbarHeight: 60.0,
          title: Text(
            'Profile User',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          )
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [

                SizedBox(
                  height: 30.h,
                ),

                sectionDataUser(),

                SizedBox(
                  height: 20.h,
                ),

                sectionMenuProfile(),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget sectionDataUser(){

    String usernameUser = StorageProvider.read(StorageKey.username);
    String emailUser = StorageProvider.read(StorageKey.email);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F5F5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(
                  'assets/images/profile.png',
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                ),

                SizedBox(
                  height: 10.h,
                ),

                Text(
                  usernameUser,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.sp,
                    color: const Color(0xFF260534),
                  ),
                ),

                SizedBox(
                  height: 3.h,
                ),

                Text(
                  emailUser,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionMenuProfile(){

    const Color primary = Color(0xFF260534);
    const Color redButton = Color(0xFFC50202);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menu Profile",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),

          Divider(
            color: const Color(0xFFA8A8A8).withOpacity(0.20),
            thickness: 1,
          ),


          SizedBox(
            height: 15.h,
          ),

          SizedBox(
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primary
              ),
              onPressed: (){

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 30.w,
                  ),

                  SizedBox(
                    width: 10.w,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Data Profile",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.sp
                        ),
                      ),
                      Text(
                        "Perbarui dan modifikasi profil",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.sp
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10.h,
          ),

          SizedBox(
            height: 56,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: primary
              ),
              onPressed: (){

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.security,
                    color: Colors.white,
                    size: 30.w,
                  ),

                  SizedBox(
                    width: 10.w,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ganti Password Anda",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.sp
                        ),
                      ),
                      Text(
                        "Perbarui dan modifikasi profil",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14.sp
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),

          SizedBox(
            height: 30.h,
          ),

          SizedBox(
            height: 55,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: redButton
              ),
              onPressed: (){
                controller.logout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30.w,
                  ),

                  SizedBox(
                    width: 10.w,
                  ),

                  Text(
                    "Keluar dari Akun",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 16.sp
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
