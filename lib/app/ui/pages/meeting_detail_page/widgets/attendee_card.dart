import 'package:flutter/material.dart';

class AttendeeCard extends StatelessWidget {
  const AttendeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ผู้เข้าร่วม',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildAttendeeTile(
                    'Natthadol Thavachpongsri',
                    'Natthatoddrill@gmail.com',
                    'assets/imgs/pic1.jpg',
                  ),
                  _buildAttendeeTile(
                    'Treesa Wattanakosol',
                    'Wattanakosol@gmail.com',
                    'assets/imgs/pic2.jpg',
                  ),
                  _buildAttendeeTile(
                    'Suthida Kittipattra',
                    'Kittipattra.burnd@gmail.com',
                    'assets/imgs/pic3.jpg',
                  ),
                  _buildAttendeeTile(
                    'Chanoknan Prangsueb',
                    'Chanoknan.look@gmail.com',
                    'assets/imgs/pic4.jpg',
                  ),
                  _buildAttendeeTile(
                    'Weerapol Udomaek',
                    'Weerapol.pungsith@gmail.com',
                    'assets/imgs/pic5.jpg',
                  ),
                  _buildAttendeeTile(
                    'Thammika Pichaiyuthasak',
                    'Pichaiyuthasak.kula@gmail.com',
                    'assets/imgs/pic6.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeTile(String name, String email, String avatarPath) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
            radius: 20,
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          subtitle: Text(
            email,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: const Icon(
            Icons.mail_outline,
            color: Colors.grey,
            size: 20,
          ),
        ),
      ],
    );
  }
}
