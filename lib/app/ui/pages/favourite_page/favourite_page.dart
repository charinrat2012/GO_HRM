
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_hrm/app/config/my_colors.dart';
import 'package:go_hrm/app/data/models/menu_model.dart';
import 'favourite_controller.dart';

class FavouritePage extends GetView<FavouriteController> {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text('เมนู',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCategorySection(
                title: 'รายการโปรด',
                isFavoriteSection: true,
              ),
              const SizedBox(height: 16),
              // --- จุดที่แก้ไข: ใช้ Obx หุ้ม Column ที่แสดงหมวดหมู่ทั้งหมด ---
              Obx(
                () => Column(
                  children: controller.allMenuCategories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildCategorySection(
                        title: category.title,
                        items: category.items,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCategorySection({
    required String title,
    List<MenuModel>? items,
    bool isFavoriteSection = false,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            trailing: isFavoriteSection
                ? Obx(
                    () => GestureDetector(
                      onTap: controller.toggleEditMode,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          controller.isEditing.value ? 'บันทึก' : 'แก้ไข',
                          style: const TextStyle(
                            color: MyColors.blue2,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 8),
          isFavoriteSection
              ? Obx(() => _buildGridView(
                    controller.favoriteItems,
                    true,
                  ))
              : _buildGridView(
                  items!,
                  false,
                ),
        ],
      ),
    );
  }

  Widget _buildGridView(List<MenuModel> items, bool isFavoriteSection) {
    if (items.isEmpty && isFavoriteSection) {
      return Obx(() => Container(
            height: 100,
            alignment: Alignment.center,
            child: Text(
              controller.isEditing.value
                  ? 'เพิ่มเมนูที่ใช้บ่อยโดยการกด +'
                  : 'ไม่มีรายการโปรด',
              style: TextStyle(color: Colors.grey[600], fontSize: 15),
            ),
          ));
    }
    final List<MenuModel> displayItems =
        !isFavoriteSection && controller.isEditing.value
            ? items.where((item) => !controller.isFavorite(item)).toList()
            : items;
    if (displayItems.isEmpty && !isFavoriteSection) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: Text(
          'ไม่มีเมนูให้เพิ่มแล้ว',
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
        ),
      );
    }
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: displayItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = displayItems[index];
        return _buildMenuItem(item, isFavoriteSection);
      },
    );
  }


  // --- จุดที่แก้ไข: เพิ่มเงื่อนไขการแสดงปุ่ม + ---
 Widget _buildMenuItem(MenuModel item, bool isFavoriteSection) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFE3F2FD),
                shape: BoxShape.circle,
              ),
              // ใช้ Obx หุ้มเพื่อให้ onPressed อัปเดตตาม isEditing
              child: Obx(
                () => IconButton(
                  // ถ้าไม่ได้อยู่ในโหมดแก้ไข ให้ใช้ onPressed จาก model
                  // ถ้าอยู่ในโหมดแก้ไข ให้เป็นฟังก์ชันเปล่า (กดไม่ได้)
                  onPressed: !controller.isEditing.value ? item.onPressed : () {},
                  icon: Icon(item.icon, color: MyColors.blue2, size: 28),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, height: 1.2),
            ),
          ],
        ),
        Obx(() {
          // (โค้ดส่วนแสดงปุ่ม + - เหมือนเดิม)
          if (!controller.isEditing.value) {
            return const SizedBox.shrink();
          }
          if (isFavoriteSection) {
            return _buildEditButton(
              icon: Icons.remove,
              onTap: () => controller.removeFromFavorites(item),
            );
          } else if (!controller.isFavorite(item) &&
              controller.favoriteItems.length < controller.favoriteLimit) {
            return _buildEditButton(
              icon: Icons.add,
              onTap: () => controller.addToFavorites(item),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    );
  }

  Widget _buildEditButton(
      {required IconData icon, required VoidCallback onTap}) {
    // (โค้ดส่วนนี้เหมือนเดิม)
    return Positioned(
      top: -4,
      right: 4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: MyColors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}