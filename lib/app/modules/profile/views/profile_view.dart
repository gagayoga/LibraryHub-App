import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/components/customTextField.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color background =  Color(0xFF260534);

    double toolbar = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
        body: SizedBox(
          width: width,
          height: bodyHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 30.h,
                ),

                sectionDataUser(),

                SizedBox(
                  height: 20.h,
                ),

                sectionMenuProfile(context, width, height),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget sectionDataUser(){
    return Obx((){
      if(controller.detailProfile.value == null){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF260534)),
            ),
          ),
        );
      }else{
        var dataProfile = controller.detailProfile.value;
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
                      dataProfile!.namaLengkap.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: const Color(0xFF260534),
                      ),
                    ),

                    SizedBox(
                      height: 3.h,
                    ),

                    Text(
                      dataProfile.email.toString(),
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
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
    });
  }

  Widget sectionMenuProfile(BuildContext context, double width, double height){

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
                controller.getDataUser();
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return sectionUpdateProfile(width, height);
                    }
                );
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
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context){
                      return sectionUpdatePassword(width, height);
                    }
                );
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

  Widget sectionUpdateProfile(double width, double height){
    const Color background =  Color(0xFF260534);

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Update Profile Pengguna',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.3,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                CustomTextField(
                    controller: controller.namalengkapController,
                    labelText: "Nama Lengkap",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Nama Lengkap";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                    controller: controller.usernameController,
                    labelText: "Username",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Username";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                    controller: controller.emailController,
                    labelText: "Email",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Email";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                    controller: controller.bioController,
                    labelText: "Bio",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Bio";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 10,
                ),

                CustomTextField(
                    controller: controller.teleponController,
                    labelText: "Telepon",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Telepon";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 25,
                ),

                SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: background,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    10.10))),
                        onPressed: () {
                          Navigator.pop(Get.context!, 'OK');
                          controller.updateProfilePost();
                        },
                        child: Obx(() => controller.loading.value?
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ):  Text(
                          "Update Profile User",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget sectionUpdatePassword(double width, double height){
    const Color background =  Color(0xFF260534);

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Update Password Pengguna',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.3,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                CustomTextField(
                    controller: controller.namalengkapController,
                    labelText: "Password Lama",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Nama Lengkap";
                      }
                      return null;
                    }
                ),

                const SizedBox(
                  height: 15,
                ),

                CustomTextField(
                    controller: controller.usernameController,
                    labelText: "Password Baru",
                    obsureText: false,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Username";
                      }
                      return null;
                    }
                ),


                const SizedBox(
                  height: 35,
                ),

                SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: background,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    10.10))),
                        onPressed: () {
                          Navigator.pop(Get.context!, 'OK');
                          controller.updateProfilePost();
                        },
                        child: Obx(() => controller.loading.value?
                        const CircularProgressIndicator(
                          color: Colors.white,
                        ):  Text(
                          "Update Password",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
