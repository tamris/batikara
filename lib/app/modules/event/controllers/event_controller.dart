import 'package:get/get.dart';

class EventModel {
  final String title;
  final String date;
  final String location;
  final String image;
  final String? description;

  EventModel({
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    this.description,
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
          'Nikmati ragam batik tradisional dan modern dari seluruh Indonesia, dengan pertunjukan budaya dan workshop membatik.',
    ),
    EventModel(
      title: 'Seminar Hari Batik',
      date: '02 Oktober 2024',
      location: 'Pendopo Balai Kota Tegal',
      image: 'assets/img/event2.jpg',
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
