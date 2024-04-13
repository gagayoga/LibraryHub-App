import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                        'History Peminjaman',
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
                        'Kumpulan data peminjaman buku Anda',
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
                    await controller.getDataPeminjaman();
                  },
                  child: GestureDetector(
                    onTap: () async {
                      await controller.getDataPeminjaman();
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
            child: Obx(() => controller.historyPeminjaman.isEmpty ?
            sectionDataKosong('Koleksi Buku') : sectionKoleksiBuku(context, width, height),
            ),
          ),
        )
    );
  }

  Widget sectionKoleksiBuku(BuildContext context, double width, double height) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children:
            List.generate(
              controller.historyPeminjaman.length,
                  (index) {
                var dataKoleksi = controller.historyPeminjaman[index];
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
                              if(dataKoleksi.status == "Selesai"){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return sectionUploadUlasan(width, height, dataKoleksi.bukuId.toString(), dataKoleksi.judulBuku.toString());
                                    }
                                );
                              }else{
                                controller.getDataDetailPeminjaman(dataKoleksi.peminjamanID.toString());
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return buktiPeminjaman(width, height);
                                    }
                                );
                              }
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
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AspectRatio(
                                        aspectRatio: 2 / 2,
                                        child: Image.network(
                                          dataKoleksi.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Positioned(
                                      left: 0,
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: dataKoleksi.status == 'Ditolak'
                                                ? const Color(0xFFEA1818)
                                                : dataKoleksi.status == 'Dipinjam'
                                                ? const Color(0xFF260534)
                                                : dataKoleksi.status ==
                                                'Selesai'
                                                ? const Color(0xFFEA1818)
                                                : const Color(0xFF1B1B1D),
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                dataKoleksi.status == 'Selesai' ? const SizedBox() : const FaIcon(
                                                  FontAwesomeIcons.circleInfo,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),


                                                dataKoleksi.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                                  width: 10,
                                                ),

                                                Text(
                                                  dataKoleksi.status == 'Selesai' ? 'Beri Ulasan' : dataKoleksi.status.toString(),
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
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
                                  dataKoleksi.kodePeminjaman!,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF260534),
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  dataKoleksi.judulBuku!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.2,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                FittedBox(
                                  child: Text(
                                    "Tanggal Pinjam : ${dataKoleksi.tanggalPinjam!}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "Deadline Pinjam : ${dataKoleksi.deadline!}",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 12.0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    "Tanggal Kembali : ${dataKoleksi.tanggalKembali!}",
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

  Widget buktiPeminjaman(double width, double height){
    return Obx((){
      if(controller.detailPeminjaman.value == null){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF260534)),
            ),
          ),
        );
      }else{
        var dataPeminjaman = controller.detailPeminjaman.value;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFF5F5F5)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),

                Text(
                  dataPeminjaman!.kodePeminjaman.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    letterSpacing: -0.3,
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.start,
                  softWrap: true,
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
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Nama Peminjam :",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          dataPeminjaman.username.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex:2,
                        child: Text(
                          "Tanggal Peminjaman :",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          dataPeminjaman.tanggalPinjam.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex:2,
                        child: Text(
                          "Deadline Peminjaman :",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          dataPeminjaman.deadline.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex:2,
                        child: Text(
                          "Tanggal Pengembalian :",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(
                          dataPeminjaman.tanggalKembali.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "Judul Buku :",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          dataPeminjaman.judulBuku.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.end,
                          softWrap: true,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note :",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: 16
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        "Kembalikan buku sesuai jadwal yang tertera di bukti peminjaman",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.3,
                            fontSize: 14
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  Widget sectionUploadUlasan(double width, double height, String idbuku, String namaBuku){
    const Color background =  Color(0xFF260534);
    const Color colorText =  Color(0xFF858896);
    return Container(
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
                  'Berikan Ulasan Buku',
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
                height: 20,
              ),

              Text(
                'Rating Buku',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),

              const SizedBox(
                height: 10,
              ),

              RatingBar.builder(
                allowHalfRating: false,
                itemCount: 5,
                minRating: 1,
                initialRating: 5,
                direction: Axis.horizontal,
                itemSize: 50,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {
                  controller.ratingBuku = value;
                },
              ),

              const SizedBox(
                height: 25,
              ),

              TextFormField(
                controller: controller.ulasanController,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.3,
                    color: background
                ),
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Ulasan Buku",
                  labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: background
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: colorText, width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder:  OutlineInputBorder(
                    borderSide: const BorderSide(color: background, width: 1.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return 'Masukan ulasan buku';
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 40,
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
                        controller.postUlasanBuku(idbuku, namaBuku);
                      },
                      child: Obx(() => controller.loadingUlasan.value?
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ):  Text(
                        "Simpan Ulasan Buku",
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
}
