// class DocModel {
//   final String type;

//   DocModel({required this.type});

//   // เมธอด copyWith
//   DocModel copyWith({String? type, int? remaining, int? total}) {
//     return DocModel(type: type ?? this.type);
//   }

//   factory DocModel.fromMap(Map<String, dynamic> map) {
//     return DocModel(type: map['type'] ?? '');
//   }
// }
class DocModel {
  final String docTypeId;
  final String type;

  DocModel({required this.type,required this.docTypeId});

  // เมธอด copyWith
  DocModel copyWith({String? type, int? remaining, int? total}) {
    return DocModel(type: type ?? this.type, docTypeId: docTypeId);
  }

  factory DocModel.fromMap(Map<String, dynamic> map) {
    return DocModel(type: map['type'] ?? '', docTypeId: map['docTypeId'] ?? '');
  }
}
