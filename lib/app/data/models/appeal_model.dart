class AppealModel {
  final String appealTypeId;
  final String type;

  AppealModel({required this.type, required this.appealTypeId});

  // เมธอด copyWith
  AppealModel copyWith({String? type, int? remaining, int? total}) {
    return AppealModel(type: type ?? this.type, appealTypeId: appealTypeId);
  }

  factory AppealModel.fromMap(Map<String, dynamic> map) {
    return AppealModel(
      type: map['type'] ?? '',
      appealTypeId: map['appealTypeId'] ?? '',
    );
  }
}
