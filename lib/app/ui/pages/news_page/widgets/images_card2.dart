import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/my_colors.dart';
import '../../../../data/models/news_card_model.dart';
import '../news_controller.dart';

class ImagesCard2 extends GetView<NewsController> {
  final NewsCardModel imgcard;
  final VoidCallback? onTap;

  const ImagesCard2({super.key, required this.imgcard, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
              ),
            height: 261,
            width: 348,
             margin: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                  child: Image.asset(
                    imgcard.imageUrl,
                    fit: BoxFit.cover,
                    height: 185,
                    width: double.infinity,
                    // width: 166,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        width: 166,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      'รีวิวการทำงานในบริษัท ABSOLUTIONS หลังจากอยู่มา 20 ปี (เเบบจริงใจไม่จริงจัง) ${imgcard.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                        children: [
                          TextSpan(text: 'ณัฐดนย์ ธวัชผ่องศรี '),
                          const TextSpan(
                            text: 'ลงเมื่อวันที่ ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: imgcard.date,
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    
                    trailing: Container(
                      
                      width: 10,
                      height: 1,
                      margin:  EdgeInsets.only(bottom: 60),
                      child: PopupMenuButton<String>(
                        // menuPadding: const EdgeInsets.all(10),
                        position:  PopupMenuPosition.under,
                        icon: Icon(Icons.more_vert,color: MyColors.blue,size: 20),
                      
                        onSelected: (String result) {},
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'settings',
                                child: Text('ตั้งค่า'),
                              ),
                            ],
                      ),
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //      Text(
                  //         news.title,
                  //         style: const TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12,
                  //           color: Colors.black,
                  //         ),
                  //         maxLines: 2,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       const SizedBox(height: 4),
                  //       Text(
                  //         news.date,
                  //         style: TextStyle(
                  //           color: Colors.grey[600],
                  //         ),
                  //         maxLines: 1,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //       const SizedBox(height: 3),
                  //       Text(
                  //         news.description,
                  //         style: TextStyle(color: Colors.grey[800], fontSize: 12),
                  //         maxLines: 4,
                  //         overflow: TextOverflow.ellipsis,
                  //       ),
                  //   ],
                  // )
                ),
              ],
            ),
          ),
        );
  }
}
