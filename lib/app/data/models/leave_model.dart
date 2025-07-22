class LeaveModel {
  final String type;

  LeaveModel({required this.type});

  // เมธอด copyWith
  LeaveModel copyWith({String? type, int? remaining, int? total}) {
    return LeaveModel(type: type ?? this.type);
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(type: map['type'] ?? '');
  }
}
