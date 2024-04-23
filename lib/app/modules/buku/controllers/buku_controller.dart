import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:libraryhub_fitra/app/data/model/buku/response_all_book.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class BukuController extends GetxController with StateMixin {
  final TextEditingController searchController = TextEditingController();

  var dataAllBook = RxList<DataBook>();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataBook() async {
    change(null, status: RxStatus.loading());

    try {
      final keyword = searchController.text.toString();
      final response;

      if (keyword == '') {
        response =
            await ApiProvider.instance().get('${Endpoint.buku}all/buku/null');
      } else {
        response = await ApiProvider.instance()
            .get('${Endpoint.buku}all/buku/$keyword');
      }

      if (response.statusCode == 200) {
        final ResponseAllBook responseBuku =
            ResponseAllBook.fromJson(response.data);
        if (responseBuku.data!.isEmpty) {
          dataAllBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataAllBook.assignAll(responseBuku.data!);
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null,
              status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
