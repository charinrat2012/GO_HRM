import 'package:flutter/material.dart';
import '../../../../data/models/news_card_model.dart';

class NewsCard extends StatelessWidget {
  final NewsCardModel news;
  final VoidCallback onTap;
  const NewsCard({super.key, required this.news, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: Colors.white,
        elevation: 0,
        // margin: EdgeInsets.only(bottom: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),

        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- ส่วนของรูปภาพ ---
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ), // ทำให้มุมมนมากขึ้น
                  child: Image.asset(
                    news.imageUrl,
                    fit: BoxFit.cover,
                    height: 120,
                    width: 166,
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
                const SizedBox(width: 16),

                // --- ส่วนของข้อความ ---
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        news.date,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        news.description,
                        style: TextStyle(color: Colors.grey[800], fontSize: 12),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
