import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {

  final loadinglogin = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();

      var response = await ApiProvider.instance().post(
          Endpoint.logout
      );

      if (response.statusCode == 200) {

        StorageProvider.clearAll();

        _showMyDialog(
                (){
              Get.offAllNamed(Routes.LOGIN);
            },
            "Logout Berhasil",
            "Silakan login kembali",
            "Lanjut");
      } else {
        _showMyDialog(
                (){
              Navigator.pop(Get.context!, 'OK');
            },
            "Pemberitahuan",
            "Logout gagal",
            "Ok"
        );
      }
      loadinglogin(false);
    } on DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data['message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loadinglogin(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            judul,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w700
            ),
          ),
          content: Text(
            deskripsi,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w500
            ),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: onPressed,
              child: Text(
                nameButton,
                style: GoogleFonts.poppins(
                    color: const Color(0xFF260534),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700
                ),
              ),
            )
          ],
        )
    );
  }
}
