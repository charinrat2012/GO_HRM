import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meeting_detail_controller.dart';
import 'widgets/attendee_card.dart';
import 'widgets/detail_meeting_card.dart';
import 'widgets/email_card.dart';
import 'widgets/file_picker_meeting.dart';
import 'widgets/meeting_card.dart';
import 'widgets/meeting_detail_head.dart';
import 'widgets/time_card.dart';
import 'widgets/update_card.dart';

class MeetingDetailPage extends GetView<MeetingDetailController> {
  const MeetingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MeetingDetailHead(),
            const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
            // 1. ประชุมกับผู้บริหาร
            MeetingCard(),
            // 2.อีเมล
            EmailCard(),
            // 3. ประเภทการเข้าประชุม
            DetailMeetingCard(),
            // 4.เริ่มเวลา
            TimeCard(),
            // 5. อัปเดต
            UpdateCard(),
            // 6.แนบไฟล์
            FilePickerMeeting(),
            // 7.ผู้เข้าร่วม
            AttendeeCard(),
            const SliverToBoxAdapter(child: SizedBox(height: 70.0)),
          ],
        ),
      ),
    );
  }
}
