import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libraryhub_fitra/app/data/provider/storage_provider.dart';

import '../../../components/customTextFieldPeminjaman.dart';
import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbuku_controller.dart';

class DetailbukuView extends GetView<DetailbukuController> {
  const DetailbukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    const Color background = Color(0xFFF5F5F5);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 50,
        titleSpacing: -5,
        title: Text(
          Get.parameters['judul'].toString(),
          style: GoogleFonts.poppins(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            ListView(
            children: [
                SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: sectionDetailBook()
                ),
                const SizedBox(height: 80),
               ],
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Obx((){
                var dataButton = controller.dataDetailBook.value?.buku;

                return Container(
                  color: const Color(0xFFF5F5F5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF260534),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.10))),
                            onPressed: () {
                              if (dataButton?.statusPeminjaman == 'Belum dipinjam') {
                                 showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return sectionPeminjamanBuku(width, height * 0.73);
                                    }
                                );
                              }else if(dataButton?.statusPeminjaman == 'Dipinjam'){
                                return;
                              }
                            },
                            child: Text(
                              dataButton?.statusPeminjaman == 'Belum dipinjam'
                                  ? 'Pinjam Buku' : 'Dipinjam',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                        )
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      )
    );
  }

  // Widget Peminjaman Buku
  Widget sectionPeminjamanBuku(double width, double height){
    const Color background =  Color(0xFF260534);

    return Obx(() {
      var dataPeminjaman = controller.dataDetailBook.value?.buku;

      if(controller.dataDetailBook.value == null){
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
        return SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Peminjaman Buku ${dataPeminjaman!.judul.toString()}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: -0.3,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),

                  const SizedBox(
                    height: 10,
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

                  CustomTextFieldPeminjaman(
                    initialValue: StorageProvider.read(StorageKey.username).toString(),
                    labelText: 'Peminjam Buku',
                    obsureText: false,
                  ),

                  CustomTextFieldPeminjaman(
                    initialValue: Get.parameters['judul'].toString(),
                    labelText: 'Judul Buku',
                    obsureText: false,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFieldPeminjaman(
                          preficIcon: const Icon(Icons.calendar_today),
                          initialValue: controller.formattedToday.toString(),
                          labelText: 'Peminjaman',
                          obsureText: false,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextFieldPeminjaman(
                          preficIcon: const Icon(Icons.calendar_today),
                          initialValue: controller.formattedTwoWeeksLater.toString(),
                          labelText: 'Pengembalian',
                          obsureText: false,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.toggleCheckBox();
                        },
                        activeColor: const Color(0xFF260534),
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan waktu peminjaman buku",
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                            fontSize: 10.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 20,
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
                            if (!controller.isChecked.value) {
                              return;
                            }
                            Navigator.pop(Get.context!, 'OK');
                            controller.addPeminjamanBuku();
                          },
                          child: Obx(() => controller.loading.value?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ):  Text(
                            "Setuju & Lanjutkan",
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
        );
      }
    });
  }

  // Data Detail Buku
  Widget sectionDetailBook(){
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;
    return Obx((){
      if (controller.dataDetailBook.isNull) {
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
      } else if (controller.dataDetailBook.value == null) {
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
      } else {
        var dataBuku = controller.dataDetailBook.value?.buku;
        var dataUlasan = controller.dataDetailBook.value?.ulasan;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: height * 0.015,
            ),

            SizedBox(
              width: width,
              height: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      height: 225,
                      width: width * 0.40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          dataBuku!.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: width * 0.035,
                    ),

                    Expanded(
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataBuku.judul!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 30.0,
                              ),
                              textAlign: TextAlign.start,
                              softWrap: true,
                            ),

                            SizedBox(
                              height: height * 0.010,
                            ),

                            FittedBox(
                              child: Text(
                                dataBuku.penulis!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            SizedBox(
                              height: height * 0.010,
                            ),

                            RatingBarIndicator(
                              rating: dataBuku.rating!,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 20,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),

                            SizedBox(
                              height: height * 0.015,
                            ),

                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  backgroundColor: const Color(0xFF260534),
                                ),
                                onPressed: (){
                                  controller.addKoleksiBuku(Get.context!);
                                },
                                child: Text(
                                  dataBuku.status == 'Tersimpan' ? 'Tersimpan' : 'Simpan Buku',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: height * 0.030,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF).withOpacity(0.30),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF61677D).withOpacity(0.20),
                      width: 0.5,
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              dataBuku.jumlahHalaman!,
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF260534),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Halaman',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 1,
                        color: Colors.white,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              dataBuku.jumlahRating!.toString(),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF260534),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Rating',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 1,
                        color: Colors.white,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              dataBuku.jumlahPeminjam!.toString(),
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF260534),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'Peminjam',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Tentang buku ini',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                  height: 1.6,
                  fontSize: 20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                dataBuku.deskripsi!.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                    height: 1.6,
                    fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            SizedBox(
              height: height * 0.030,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ulasan Buku',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                      height: 1.6,
                      fontSize: 20,
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          context: Get.context!,
                          builder: (BuildContext context){
                            return moreUlasanBuku(dataUlasan, dataBuku.judul.toString());
                          }
                      );
                    },
                    child: Text(
                      'Lihat semua >',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFB80000),
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.6,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: buildUlasanList(dataUlasan),
            ),
          ],
        );
      }
    }
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length > 4 ? 4 : ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF424242).withOpacity(0.10),
                  width: 0.5,
                )),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/foto_profile.png',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.035,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            ulasan.users?.username ?? '',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 14),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          // Menampilkan rating di bawah teks penulis
                          RatingBarIndicator(
                            direction: Axis.horizontal,
                            rating: ulasan.rating!.toDouble(),
                            itemCount: 5,
                            itemSize: 14,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    ulasan.ulasan!,
                    maxLines: 3,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF260534),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget moreUlasanBuku(List<Ulasan>? ulasanList, String buku) {
    final width = MediaQuery.of(Get.context!).size.width;

    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              Text(
                "Ulasan Buku $buku",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -0.3,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.start,
                softWrap: true,
              ),

              const SizedBox(
                height: 15,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  color: Colors.grey,
                  height: 2,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ulasanList != null && ulasanList.isNotEmpty
                  ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ulasanList.length,
                itemBuilder: (context, index) {
                  Ulasan ulasan = ulasanList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF424242).withOpacity(0.10),
                            width: 0.5,
                          )),
                      width: width,
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Center(
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        'assets/images/foto_profile.png',
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: width * 0.035,
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ulasan.users?.username ?? '',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    // Menampilkan rating di bawah teks penulis
                                    RatingBarIndicator(
                                      direction: Axis.horizontal,
                                      rating: ulasan.rating!.toDouble(),
                                      itemCount: 5,
                                      itemSize: 14,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Text(
                              ulasan.ulasan!,
                              maxLines: 3,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Container(
                width: width,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFF260534),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF424242),
                    width: 0.5,
                  ),
                ),
                child: Text(
                  'Belum ada ulasan buku',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
