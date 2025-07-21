import '../../ui/utils/assets.dart';

class UserModel {
  final String userId;
  final String imgProfile;
  final String userName;
  final String employeeId;
  final String idCard;
  final String section;
  final String nameTitle;
  final String nickName;
  final String firstNameTH;
  final String lastNameTH;
  final String firstNameEN;
  final String lastNameEN;
  final String sex;
  final String birthday;
  final String birthplace;
  final String age;
  final String email;
  final String phone;
  final String addressTH;
  final String addressEN;
  final String password;

  // final List<String> nametitle;
  // final List<String> imagedetails;

  UserModel({
    required this.userId,
    required this.imgProfile,
    required this.userName,
    required this.employeeId,
    required this.idCard,
    required this.section,
    required this.nameTitle,
    required this.nickName,
    required this.firstNameTH,
    required this.lastNameTH,
    required this.firstNameEN,
    required this.lastNameEN,
    required this.sex,
    required this.birthday,
    required this.birthplace,
    required this.age,
    required this.email,
    required this.phone,
    required this.addressTH,
    required this.addressEN,
    required this.password,
  });

  // Factory constructor สำหรับสร้าง Object จาก Map (เช่นจาก Reslist)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      imgProfile: map['imgProfile'] ?? Assets.assetsImgsProfile,
      userName: map['userName'] ?? '',
      employeeId: map['employeeId'] ?? '',
      idCard: map['idCard'] ?? '',
      section: map['section'] ?? '',
      nameTitle: map['nameTitle'] ?? '',
      nickName: map['nickName'] ?? '',
      firstNameTH: map['firstNameTH'] ?? '',
      lastNameTH: map['lastNameTH'] ?? '',
      firstNameEN: map['firstNameEN'] ?? '',
      lastNameEN: map['lastNameEN'] ?? '',
      sex: map['sex'] ?? '',
      birthday: map['birthday'] ?? '',
      birthplace: map['birthplace'] ?? '',
      age: map['age'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      addressTH: map['addressTH'] ?? '',
      addressEN: map['addressEN'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // เมธอด copyWith เพื่อสร้าง Object ใหม่พร้อม Property ที่เปลี่ยนแปลง
  UserModel copyWith({
    String? userId,
    String? imgProfile,
    String? userName,
    String? employeeId,
    String? idCard,
    String? section,
    String? nameTitle,
    String? nickName,
    String? firstNameTH,
    String? lastNameTH,
    String? firstNameEN,
    String? lastNameEN,
    String? sex,
    String? birthday,
    String? birthplace,
    String? age,
    String? email,
    String? phone,
    String? addressTH,
    String? addressEN,
    String? password,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      imgProfile: imgProfile ?? this.imgProfile,
      userName: userName ?? this.userName,
      employeeId: employeeId ?? this.employeeId,
      idCard: idCard ?? this.idCard,
      section: section ?? this.section,
      nameTitle: nameTitle ?? this.nameTitle,
      nickName: nickName ?? this.nickName,
      firstNameTH: firstNameTH ?? this.firstNameTH,
      lastNameTH: lastNameTH ?? this.lastNameTH,
      firstNameEN: firstNameEN ?? this.firstNameEN,
      lastNameEN: lastNameEN ?? this.lastNameEN,
      sex: sex ?? this.sex,
      birthday: birthday ?? this.birthday,
      birthplace: birthplace ?? this.birthplace,
      age: age ?? this.age,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressTH: addressTH ?? this.addressTH,
      addressEN: addressEN ?? this.addressEN,
      password: password ?? this.password,
    );
  }
}
