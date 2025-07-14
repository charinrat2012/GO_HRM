import 'package:flutter/material.dart';
import 'package:go_hrm/app/config/my_colors.dart';

import '../../../../data/models/images_card_model.dart';

class ImagesCard extends StatelessWidget {
  final ImageCardModel imgcard;

  const ImagesCard({
    super.key,
    required this.imgcard,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 219,
      width: 358,
      margin: const EdgeInsets.only(left: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        
        child: Image.asset(
          
          imgcard.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red, size: 40);
          },
        ),
      ),
    );
  }
}
