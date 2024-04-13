import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        title: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Koleksi Buku',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(
                        height: 3,
                      ),

                      Text(
                        'Kumpulan dataKoleksi yang Anda simpan dan sukai',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                RefreshIndicator(
                  onRefresh: () async {
                    await controller.getData();
                  },
                  child: GestureDetector(
                    onTap: () async {
                      await controller.getData();
                    },
                    child: const Icon(
                      CupertinoIcons.refresh_circled_solid,
                      color: Color(0xFF260534),
                      size: 30,
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(() => controller.koleksiBook.isEmpty ?
              sectionDataKosong('Koleksi Buku') : sectionKoleksiBuku(),
          ),
        ),
      )
    );
  }
  
  Widget sectionKoleksiBuku() {
    return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              children:
              List.generate(
                controller.koleksiBook.length,
                    (index) {
                  var dataKoleksi = controller.koleksiBook[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: MediaQuery.of(Get.context!).size.width,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5).withOpacity(0.60),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Gambar di sebelah kiri
                          Flexible(
                            flex:3,
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(Routes.DETAILBUKU,
                                  parameters: {
                                    'id': (dataKoleksi.bukuID ?? 0).toString(),
                                    'judul': (dataKoleksi.judul!).toString()
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: 150,
                                  decoration : BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 5), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  // Lebar gambar 40% dari layar
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: 2 / 2,
                                      child: Image.network(
                                        dataKoleksi.coverBuku.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataKoleksi.judul!,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF260534),
                                      fontSize: 18.0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    dataKoleksi.deskripsi!,
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      "Penulis : ${dataKoleksi.penulis!}",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: Center(
                              child: InkWell(
                                onTap: (){
                                  controller.deleteKoleksiBook(dataKoleksi.bukuID!.toString(), Get.context!);
                                },
                                child: const Icon(
                                  CupertinoIcons.trash_fill,
                                  color: Color(0xFFFF0000),
                                  size: 26,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
          )
      );
  }

  Widget sectionDataKosong(String text){
    const Color background = Color(0xFF260534);
    const Color borderColor = Color(0xFF424242);
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1.3,
          )
      ),
      child: Center(
        child: Text(
          'Maaf Data $text Kosong',
          style: GoogleFonts.inriaSans(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
