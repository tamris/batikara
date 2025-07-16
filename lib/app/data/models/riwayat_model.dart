import 'package:intl/intl.dart';

class RiwayatModel {
  final String label;
  final String date;
  final double confidence;

  RiwayatModel({
    required this.label,
    required this.date,
    required this.confidence,
  });

  factory RiwayatModel.fromJson(Map<String, dynamic> json) {
    final rawDate = DateTime.parse(json['timestamp']);
    final formattedDate =
        DateFormat('dd MMMM yyyy', 'id_ID').format(rawDate);

    return RiwayatModel(
      label: json['label'],
      date: formattedDate,
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}
