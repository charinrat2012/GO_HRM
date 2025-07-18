class DocModel {
  final String type;

  DocModel({required this.type});

  // เมธอด copyWith
  DocModel copyWith({String? type, int? remaining, int? total}) {
    return DocModel(type: type ?? this.type);
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(type: map['type'] ?? '');
  }
}
