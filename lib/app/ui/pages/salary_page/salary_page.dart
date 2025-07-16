import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'salary_controller.dart';
import 'widgets/year_filter.dart'; // สมมติว่า YearFilter เป็น widget ที่จัดการแสดงผลปี

class SalaryPage extends GetView<SalaryController> {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              floating: false,
              pinned: false,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 14.0,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title: const Text(
                'เงินเดือน',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.save, color: Colors.black, size: 18.0),
                  onPressed: () {},
                ),
              ],
            ),

            const YearFilter(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'ปัจจุบัน',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,  vertical: 15.0,),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'ทั้งหมด',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
             SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'พฤษภาคม',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
             SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, 
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, 
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  //GestureDetector เพื่อให้แตะได้
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    margin: EdgeInsets.zero, // ลบ margin เริ่มต้นของ Card
                    child: Container(
                      padding: const EdgeInsets.all(16.0), // Padding ภายในกล่อง
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'มิถุนายน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4), // ช่องว่างระหว่างข้อความ
                              Text(
                                'วันที่จ่าย 25/06/2025 เวลา 12.08 น.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
