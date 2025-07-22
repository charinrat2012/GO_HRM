class AppealModel {
  final String type;

  AppealModel({required this.type});

  // เมธอด copyWith
  AppealModel copyWith({String? type, int? remaining, int? total}) {
    return AppealModel(type: type ?? this.type);
  }

  factory AppealModel.fromMap(Map<String, dynamic> map) {
    return AppealModel(type: map['type'] ?? '');
  }
}
