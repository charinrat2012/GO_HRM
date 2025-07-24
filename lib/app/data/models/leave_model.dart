// class LeaveModel {
//   final String leaveTypeId;
//   final String type;

//   LeaveModel({required this.type, this.leaveTypeId = ''});

//   // เมธอด copyWith
//   LeaveModel copyWith({String? type, int? remaining, int? total}) {
//     return LeaveModel(type: type ?? this.type);
//   }

//   factory LeaveModel.fromMap(Map<String, dynamic> map) {
//     return LeaveModel(type: map['type'] ?? '');
//   }
// }
class LeaveModel {
  final String leaveTypeId;
  final String type;

  LeaveModel({required this.type,required this.leaveTypeId});

  // เมธอด copyWith
  LeaveModel copyWith({String? type, int? remaining, int? total}) {
    return LeaveModel(type: type ?? this.type, leaveTypeId: leaveTypeId);
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(type: map['type'] ?? '', leaveTypeId: map['leaveTypeId'] ?? '');
  }
}
