// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'appeal_controller.dart';
// import 'widgets/card_title.dart';
// import 'widgets/filter_section.dart';
// import 'widgets/head_leave.dart';
// import 'widgets/history_card_list.dart';
// import 'widgets/request_button.dart';
// import 'widgets/segmented_control.dart';

// class AppealPage extends GetView<AppealController> {
//   const AppealPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             HeadLeave(),

//             // const SliverToBoxAdapter(
//             //   child: Divider(color: Colors.grey, thickness: 1),
//             // ),
//             SliverToBoxAdapter(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SegmentedControl(),
//                     const SizedBox(height: 16),
//                     RequestButton(),
//                     const SizedBox(height: 16),
//                     FilterSection(),
//                     const SizedBox(height: 24),
//                     CardTitle(),
//                   ],
//                 ),
//               ),
//             ),

//             // --- แก้ไข: เปลี่ยน _buildHistoryList ให้เป็น SliverList ---
//             HistoryCardList(),
//             SliverToBoxAdapter(child: const SizedBox(height: 64)),
//           ],
//         ),
//       ),
//     );
//   }
// }
