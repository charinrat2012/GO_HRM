import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';
import 'widgets/details_profile.dart';
import 'widgets/head_details.dart';
import 'widgets/profile_head.dart';
import 'widgets/profile_image.dart';

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
                children: [ProfileImage(), HeadDetails(), DetailsProfile()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
