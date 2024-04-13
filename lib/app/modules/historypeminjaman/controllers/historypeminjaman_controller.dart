import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/peminjaman/response_detail_peminjaman.dart';
import '../../../data/model/peminjaman/response_history_peminjaman.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class HistorypeminjamanController extends GetxController with StateMixin{

  var historyPeminjaman = RxList<DataHistory>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  var detailPeminjaman = Rxn<DetailPeminjaman>();

  // Post Ulasan
  double ratingBuku= 0;
  final loadingUlasan = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ulasanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataPeminjaman();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataPeminjaman() async {
    change(null, status: RxStatus.loading());

    try {
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.pinjamBuku}/$idUser');

      if (responseHistoryPeminjaman.statusCode == 200) {
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseHistory.data!.isEmpty) {
          historyPeminjaman.clear();
          change(null, status: RxStatus.empty());
        } else {
          historyPeminjaman.assignAll(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  postUlasanBuku(String buku, String namaBuku) async {
    loadingUlasan(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        int ratingBukuInt = ratingBuku.round();
        final response = await ApiProvider.instance().post(Endpoint.ulasanBuku,
            data: dio.FormData.fromMap(
                {
                  "Rating": ratingBukuInt,
                  "BukuID": buku,
                  "Ulasan": ulasanController.text.toString()
                }
            )
        );
        if (response.statusCode == 201) {
          _showMyDialog(
                  (){
                Navigator.of(Get.context!).pop();
              },
              "Pemberitahuan",
              "Ulasan Buku $namaBuku berhasil di simpan",
              "Ok");
          ulasanController.text = '';

        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Ulasan Gagal disimpan, Silakan coba kembali",
              "Ok"
          );
        }
      }
      loadingUlasan(false);
    } on dio.DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data['Message']}",
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
      loadingUlasan(false);
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

  Future<void> getDataDetailPeminjaman(String? idPinjam) async {
    detailPeminjaman.value == null;
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailPeminjaman}/$idPinjam');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailPeminjaman responseDetailPeminjaman = ResponseDetailPeminjaman.fromJson(responseDetailBuku.data);

        if (responseDetailPeminjaman.data == null) {
          detailPeminjaman.value == null;
          change(null, status: RxStatus.empty());
        } else {
          detailPeminjaman(responseDetailPeminjaman.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
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
