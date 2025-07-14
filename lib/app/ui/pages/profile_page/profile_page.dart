import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/profile_page/widgets/details_profile.dart';
import 'package:go_hrm/app/ui/pages/profile_page/widgets/head_details.dart';
import 'package:go_hrm/app/ui/pages/profile_page/widgets/profile_image.dart';
import 'package:go_hrm/app/ui/utils/assets.dart';

import 'profile_controller.dart';
import 'widgets/profile_head.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          slivers: [
            ProfileHead(),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                ProfileImage(),
                HeadDetails(),
                DetailsProfile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}
