// lib/app/data/models/leave_quota_model.dart

class QuotaModel {
  final String type;
  final int remaining;
  final int total;

  QuotaModel({
    required this.type,
    required this.remaining,
    required this.total,
  });

  // เมธอด copyWith
  QuotaModel copyWith({String? type, int? remaining, int? total}) {
    return QuotaModel(
      type: type ?? this.type,
      remaining: remaining ?? this.remaining,
      total: total ?? this.total,
    );
  }

  factory QuotaModel.fromMap(Map<String, dynamic> map) {
    return QuotaModel(
      type: map['type'] ?? '',
      remaining: map['remaining'] ?? 0,
      total: map['total'] ?? 0,

    );
  }
}
