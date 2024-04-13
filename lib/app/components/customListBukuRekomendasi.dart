import  'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListRekomendasiBuku extends StatelessWidget {
  final context;

  CustomListRekomendasiBuku({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "assets/images/buku/buku1.png",
      judulBuku: "Netflix",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku2.png",
      judulBuku: "Fearless Girls",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku3.png",
      judulBuku: "Need For Speed",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku4.png",
      judulBuku: "Ancika",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku5.png",
      judulBuku: "Midnight Fame",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku6.png",
      judulBuku: "Rasa Dalam Aksara",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku4.png",
      judulBuku: "Ancika",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku5.png",
      judulBuku: "Midnight Fame",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku6.png",
      judulBuku: "Rasa Dalam Aksara",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 9,
        separatorBuilder: (context, _) => SizedBox(width: 15,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
})=> Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                items.imageURl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        AutoSizeText(
          items.judulBuku,
          maxLines: 1,
          maxFontSize: 16,
          minFontSize: 12,
          style: GoogleFonts.inriaSans(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
});
}
