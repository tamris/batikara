import 'package:get/get.dart';

class EventModel {
  final String title;
  final String date;
  final String location;
  final String image;
  final String description;

  EventModel({
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    required this.description,
  });
}

class EventController extends GetxController {
  final events = <EventModel>[
    EventModel(
      title: 'Workshop Batik',
      date: '20 November 2024',
      location: 'Galery Batik Tegal',
      image: 'assets/img/event1.jpg',
      description:
          'KOTA TEGAL - Dalam rangka memperingati Hari Batik Nasional pada tanggal 2 Oktober 2024 mendatang, '
          'Dewan Kerajinan Nasional Daerah (Dekranasda) Kota Tegal akan menyelenggarakan Batik Fashion Show Tegal '
          'Laka-laka dengan tema "Inspiring of The Sea". Hal ini disampaikan Plt. Kepala Dinas Tenaga Kerja dan '
          'Perindustrian (Disnakerin) Kota Tegal, Rita Marlianawati pada saat Rapat Koordinasi persiapan Peringatan '
          'Hari Batik Nasional tahun 2024, Kamis (5/9/2024) di Gedung Dekranasda Kota Tegal, Komplek Balai Kota Tegal.\n\n'
          'Pj. Wali Kota Tegal, Dadang Somantri yang hadir dalam Rakor tersebut menyampaikan apresiasi pada rencana '
          'pelaksanaan Batik Fashion Show Tegal Laka-laka dalam rangka memperingati Hari Batik Nasional tersebut. '
          'Ia mengimbau agar acara tersebut dipersiapkan sebaik mungkin, dan tetap melibatkan penggiat, dan pengrajin '
          'batik tegalan, agar semakin hidup.\n\nIlahasarua.(*)',
    ),
    EventModel(
      title: 'Seminar Hari Batik',
      date: '02 Oktober 2024',
      location: 'Pendopo Balai Kota Tegal',
      image: 'assets/img/event2.jpg',
      description:
          'KOTA TEGAL - Dalam rangka memperingati Hari Batik Nasional pada tanggal 2 Oktober 2024 mendatang, '
          'Dewan Kerajinan Nasional Daerah (Dekranasda) Kota Tegal akan menyelenggarakan Batik Fashion Show Tegal '
          'Laka-laka dengan tema "Inspiring of The Sea". Hal ini disampaikan Plt. Kepala Dinas Tenaga Kerja dan '
          'Perindustrian (Disnakerin) Kota Tegal, Rita Marlianawati pada saat Rapat Koordinasi persiapan Peringatan '
          'Hari Batik Nasional tahun 2024, Kamis (5/9/2024) di Gedung Dekranasda Kota Tegal, Komplek Balai Kota Tegal.\n\n'
          'Pj. Wali Kota Tegal, Dadang Somantri yang hadir dalam Rakor tersebut menyampaikan apresiasi pada rencana '
          'pelaksanaan Batik Fashion Show Tegal Laka-laka dalam rangka memperingati Hari Batik Nasional tersebut. '
          'Ia mengimbau agar acara tersebut dipersiapkan sebaik mungkin, dan tetap melibatkan penggiat, dan pengrajin '
          'batik tegalan, agar semakin hidup.\n\nIlahasarua.(*)',
    ),
    EventModel(
      title: 'Festival Batik',
      date: '1 Oktober 2024',
      location: 'Alun-Alun Tegal',
      image: 'assets/img/event3.jpg',
      description:
          'Nikmati ragam batik tradisional dan modern dari seluruh Indonesia, dengan pertunjukan budaya dan workshop membatik.',
    ),
    EventModel(
      title: 'Festival Batik',
      date: '1 Oktober 2024',
      location: 'Alun-Alun Tegal',
      image: 'assets/img/event3.jpg',
      description:
          'Nikmati ragam batik tradisional dan modern dari seluruh Indonesia, dengan pertunjukan budaya dan workshop membatik.',
    ),
    // Tambahkan lagi sesuai kebutuhan
  ].obs;
}
