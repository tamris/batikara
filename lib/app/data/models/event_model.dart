class EventModel {
  final String id;
  final String title;
  final String date;
  final String location;
  final String image;
  final String description;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.image,
    required this.description,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['judul'],
      date: json['waktu'],
      location: json['lokasi'],
      image: json['foto'], // jika foto hanya filename, sesuaikan nanti di View
      description: json['deskripsi'],
    );
  }
}
