class NewsCardModel {
  final String newsId;
  // final String ownerName;
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String deiailstitle;
  final List<String> deiails;
  final List<String> imagedetails;
 

  NewsCardModel({
    required this.newsId,
    // required this.ownerName,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.deiails,
    required this.imagedetails,
    required this.deiailstitle,
  });

  // Factory constructor สำหรับสร้าง Object จาก Map (เช่นจาก Reslist)
  factory NewsCardModel.fromMap(Map<String, dynamic> map) {
    return NewsCardModel(
      newsId: map['newsId'] ?? '',
      // ownerName: map['ownerName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      deiails: map['deiails'] ?? [],
      imagedetails: map['imagedetails'] ?? [],
      deiailstitle: map['deiailstitle'] ?? [],
    );
  }

  // เมธอด copyWith เพื่อสร้าง Object ใหม่พร้อม Property ที่เปลี่ยนแปลง
  NewsCardModel copyWith({
    String? newsId,
    // String? ownerName,
    String? imageUrls,
    String? title,
    String? description,
    String? date,
    String? deiailstitle,
    List<String>? deiails,
    List<String>? imagedetails,
    
  }) {
    return NewsCardModel(
      newsId: newsId ?? this.newsId,
      // ownerName: ownerName ?? this.ownerName,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      deiails: deiails ?? this.deiails,
      imagedetails: imagedetails ?? this.imagedetails,
      deiailstitle: deiailstitle ?? this.deiailstitle,
    );
  }
}
