import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/ui/pages/news_details_page/widgets/news_details_head.dart';

import '../../../data/models/news_card_model.dart';
import '../../../routes/app_routes.dart';
import '../news_page/widgets/news_card.dart';
import 'news_details_controller.dart';

class NewsDetailsPage extends GetView<NewsDetailsController> {
  final NewsCardModel news;
  const NewsDetailsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            NewsDetailsHead(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ใช้ news.imageUrl สำหรับรูปหลัก
                  Image.asset(
                    news.imageUrl,
                    width: 390,
                    height: 216,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ใช้ news.title สำหรับหัวข้อข่าว
                        Text(
                          news.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        Row(
                          children: [
                            // ใช้ news.date สำหรับวันที่
                            Text(
                              news.date,
                              style: const TextStyle(
                                color: Colors.black,
                                // fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(width: 20),

                            CircleAvatar(
                              radius: 10.0,
                              backgroundImage: AssetImage(
                                'assets/imgs/pic3.jpg',
                              ),
                            ),
                            const SizedBox(width: 8.0),

                            const Text(
                              'ณัฐดนย์ ธวัชผ่องศรี',
                              style: TextStyle(
                                color: Colors.black,
                                // fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // ใช้ news.description สำหรับข้อความสรุปหรือหัวข้อรอง
                        Text(
                          news.deiailstitle,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // ใช้ news.deiails[0] สำหรับเนื้อหาส่วนแรก
                        Text(
                          news.deiails[0],
                          style: TextStyle(color: Colors.grey), //fontSize: 14.0
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // รูปภาพที่ 2 ใช้ news.imagedetails[0]
                  if (news.imagedetails.isNotEmpty)
                    Image.asset(
                      news.imagedetails[0],
                      width: 390,
                      height: 216,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      // ใช้ news.deiails[1] สำหรับเนื้อหาที่เกี่ยวข้องกับรูปภาพที่ 2
                      news.deiails.length > 1 ? news.deiails[1] : '',
                      style: TextStyle(color: Colors.grey), //fontSize: 14.0
                    ),
                  ),
                  const SizedBox(height: 20),

                  // รูปภาพที่ 3 ใช้ news.imagedetails[1]
                  if (news.imagedetails.length > 1) // ตรวจสอบว่ามีรูปภาพใน List
                    Image.asset(
                      news.imagedetails[1],
                      width: 390,
                      height: 216,
                      fit: BoxFit.cover,
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      // ใช้ news.deiails[2] สำหรับเนื้อหาที่เกี่ยวข้องกับรูปภาพที่ 3
                      news.deiails.length > 2
                          ? news.deiails[2]
                          : '', // ตรวจสอบความยาวของ List
                      style: TextStyle(color: Colors.grey), //fontSize: 14.0
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Text(
                      'ข่าวอื่นๆ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Obx(
                    () => controller.newscard.isEmpty
                        ? const Center(child: Text('No news'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.newscard.length,
                            itemBuilder: (context, index) {
                              final relatedNews = controller.newscard[index];
                              return NewsCard(
                                news: relatedNews,
                                onTap: () => Get.offAndToNamed(
                                  AppRoutes.NEWS_DETAILS,
                                  arguments: relatedNews,
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
