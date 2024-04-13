import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/components/customTextField.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const Color background =  Color(0xFF260534);
    const Color colorText =  Color(0xFF858896);

    final width = MediaQuery.of(context).size.width;


    return ScreenUtilInit(
      builder: (context, _) => Scaffold(
        body: Container(
          color: background,
          width: width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/splash/background_login.png'),
                          fit: BoxFit.cover,
                        )),
                    child: Center(
                      child: SizedBox(
                        width: width * 0.60,
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                        ),
                      ),
                    )
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.75,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox(
                            height: 40.h,
                          ),

                          Text(
                            'Sign In',
                            maxLines:1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 40.sp,
                            ),
                          ),

                          SizedBox(
                            height: 5.h,
                          ),

                          Text(
                            'Silakan masuk ke akun Anda untuk menikmati akses penuh ke LibraryHub.',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: colorText
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(
                            height: 40.h,
                          ),

                          CustomTextField(
                              controller: controller.emailController,
                              labelText: "Email Address",
                              obsureText: false,
                              preffixIcon: const Icon(Icons.email),
                              validator:  (value) {
                                if (value!.isEmpty) {
                                  return 'Pleasse input email address';
                                } else if (!EmailValidator.validate(value)) {
                                  return 'Email address tidak sesuai';
                                } else if (!value.endsWith('@smk.belajar.id')) {
                                  return 'Email harus @smk.belajar.id';
                                }

                                return null;
                              },
                          ),

                          SizedBox(
                            height: 15.h,
                          ),

                          Obx(() =>
                          CustomTextField(
                              controller: controller.passwordController,
                              labelText: "Password",
                              obsureText: controller.isPasswordHidden.value,
                              preffixIcon: const Icon(Icons.lock),
                              suffixIcon: InkWell(
                                child: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20,
                                  color: background,
                                ),
                                onTap: () {
                                  controller.isPasswordHidden.value =
                                  !controller.isPasswordHidden.value;
                                },
                              ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please input password';
                              } else if (value.length < 8){
                                return 'Panjang password harus lebih dari 8';
                              }
                              // Validasi setidaknya satu huruf besar
                              else if (!value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password harus mengandung satu huruf besar';
                              }
                              // Validasi setidaknya satu karakter khusus
                              else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'Password harus mengandung satu karakter khusus';
                              }
                              // Validasi setidaknya satu angka
                              else if (!value.contains(RegExp(r'[0-9]'))) {
                                return 'Password harus mengandung minimal 1 angka';
                              }
                              return null;
                            },
                          ),
                          ),

                          SizedBox(
                            height: 30.h,
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
                                  onPressed: () => controller.login(),
                                  child: Obx(() => controller.loadinglogin.value?
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  ):  Text(
                                    "Sign In",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )
                              )
                              )
                          ),

                          SizedBox(
                            height: 25.h,
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don’t have account?',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Get.offAllNamed(Routes.REGISTER);
                                  },
                                  child: Text('Sign Up',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: background,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
