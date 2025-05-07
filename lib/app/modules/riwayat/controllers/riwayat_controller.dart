import 'package:get/get.dart';

class RiwayatModel {
  final String title;
  final String date;
  final String image;
  final String akurasi;

  RiwayatModel({
    required this.title,
    required this.date,
    required this.image,
    required this.akurasi,
  });
}

class RiwayatController extends GetxController {
  final riwayat = <RiwayatModel>[
    RiwayatModel(
        title: "Motif Poci Tahu Aci",
        date: "04 Mei 2025",
        image: "assets/images/poci_tahu_aci.jpg",
        akurasi: "98%"),
    RiwayatModel(
        title: "Motif Gribigan",
        date: "04 Mei 2025",
        image: "assets/images/gribigian.jpg",
        akurasi: "89%"),
    RiwayatModel(
        title: "Motif Sidomukti",
        date: "04 Mei 2025",
        image: "assets/images/sidomukti.jpg",
        akurasi: "79%"),
    RiwayatModel(
        title: "Motif Sekar Jagad",
        date: "04 Mei 2025",
        image: "assets/images/sidomukti.jpg",
        akurasi: "79%"),
    RiwayatModel(
        title: "Motif Sidomulyo",
        date: "04 Mei 2025",
        image: "assets/images/sidomukti.jpg",
        akurasi: "79%"),
  ].obs;
}
