class GalleryModel {
  final String id;
  final String namaBatik;
  final String deskripsi;
  final String image;
  bool isFavorite;

  GalleryModel({
    required this.id,
    required this.namaBatik,
    required this.deskripsi,
    required this.image,
    this.isFavorite = false, // ✅ default false
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'],
      namaBatik: json['nama_batik'],
      deskripsi: json['deskripsi'],
      image: json['image'],
      isFavorite: false, // ✅ pastikan diisi walaupun dari backend tidak ada
    );
  }
}
