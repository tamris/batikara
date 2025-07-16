class StatistikModel {
  final String label;
  final int count;

  StatistikModel({required this.label, required this.count});

  factory StatistikModel.fromJson(Map<String, dynamic> json) {
    return StatistikModel(
      label: json['label'],
      count: json['count'],
    );
  }
}
