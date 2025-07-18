class ImageCardModel {
  final String imageUrl;
  final String title;

  ImageCardModel({required this.imageUrl, required this.title});

  factory ImageCardModel.fromMap(Map<String, dynamic> map) {
    return ImageCardModel(
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
    );
  }

  // เมธอด copyWith เพื่อสร้าง Object ใหม่พร้อม Property ที่เปลี่ยนแปลง
  ImageCardModel copyWith({String? imageUrl, String? title}) {
    return ImageCardModel(
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
    );
  }
}
