class Article {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime? createdAt; // bisa null kalau backend belum support

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}
