import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/components/customImageCarousel.dart';
import 'package:libraryhub_fitra/app/data/provider/storage_provider.dart';
import 'package:libraryhub_fitra/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final topPadding = MediaQuery.of(context).padding.top;
    final toolbarHeight = AppBar().preferredSize.height;
    const bottomNavBarHeight = kBottomNavigationBarHeight;

    // Hitung tinggi body
    final bodyHeight = height - topPadding - toolbarHeight - bottomNavBarHeight;

    const Color background = Color(0xFF260534);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light,
    ));

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
            backgroundColor: background,
            automaticallyImplyLeading: false,
            toolbarHeight: 65.0,
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
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
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AutoSizeText(
                            ucapan,
                            textAlign: TextAlign.start,
                            minFontSize: 14,
                            maxFontSize: 18,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),

                  InkWell(
                    onTap: (){

                    },
                    child: const Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshData();
            },
            child: Container(
              width: width,
              height: bodyHeight,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                              child: const CustomImageCarousel()
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Obx(() => controller.kategoriBuku.isEmpty ?
                          shimmersectionKategoriBuku() : sectionKategoriBuku(),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(
                              "Rekomendasi",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF260534),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Obx(() => controller.newBooks.isEmpty ?
                              shimmersectionListBuku() : sectionListBuku(),
                          )
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

  Widget sectionListBuku() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          controller.newBooks.length,
              (index) {
            var buku = controller.newBooks[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBUKU,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judulBuku!).toString()
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(Get.context!).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5).withOpacity(0.60),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Gambar di sebelah kiri
                      Flexible(
                        flex:2,
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
                                  buku.coverBuku.toString(),
                                  fit: BoxFit.cover,
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
                                buku.judulBuku!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF260534),
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                buku.deskripsi!,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Penulis : ${buku.penulisBuku!}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget shimmersectionListBuku() {
    int itemCount = 6;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            itemCount,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 18,
                              color: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              height: 36,
                              color: Colors.white,
                            ),
                            Container(
                              width: double.infinity,
                              height: 14,
                              color: Colors.white,
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
      ),
    );
  }

  Widget sectionKategoriBuku() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        mainAxisSpacing: 5,
        childAspectRatio: 5 / 1.5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.kategoriBuku.length,
      itemBuilder: (context, index) {
        var buku = controller.kategoriBuku[index];
        return SizedBox(
          width: 150, // Lebar item dalam grid
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.BOOKBYKATEGORI,
                  parameters: {
                    'idKategori': (buku.kategoriID ?? 0).toString(),
                    'namaKategori': (buku.namaKategori!).toString()
                  },
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF260534),
                shape: RoundedRectangleBorder( // Membuat tombol menjadi kotak
                  borderRadius: BorderRadius.circular(5), // Menentukan sudut kotak
                ),
              ),
              child: FittedBox(
                child: Text(
                  buku.namaKategori!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget shimmersectionKategoriBuku(){
    int itemCount = 4;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 5,
          childAspectRatio: 5 / 1.5,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                width: double.infinity,
                height: 45,
                color: Colors.white,
                child: Text(
                  'Judul Kategori',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
