import 'package:flutter/material.dart';

import '../../../../data/models/user_model.dart';
import '../../../utils/assets.dart';

class ProfileImage extends StatelessWidget {
final UserModel user;
  const ProfileImage({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      user.imgProfile ?? Assets.assetsImgsProfile,
      height: 390,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
