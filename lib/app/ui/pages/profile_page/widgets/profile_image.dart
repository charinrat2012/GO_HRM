import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.assetsImgsProfile,
      height: 390,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
