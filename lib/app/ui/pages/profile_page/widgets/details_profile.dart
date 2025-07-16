import 'package:flutter/material.dart';

class DetailsProfile extends StatelessWidget {
  const DetailsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileTextField(
                label: 'ชื่อผู้ใช้งาน',
                filledText: 'ณัฐดนย์ ธวัชผ่องศรี',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'รหัสพนักงาน',
                filledText: '20500423546',
              ),
              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'เลขบัตรประชาชน',
                filledTextLeft: '1102200213456  ',
                labelRight: 'แผนก',
                filledTextRight: 'ยูไอดีไซนเนอร์',
              ),

              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'คำนำหน้าชื่อ',
                filledTextLeft: 'นาย',
                labelRight: 'ชื่อเล่น',
                filledTextRight: 'ดริว',
              ),

              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'ชื่อจริง (ไทย)',
                filledTextLeft: 'ณัฐดนย์',
                labelRight: 'นามสกุล (ไทย)',
                filledTextRight: 'ธวัชผ่องศรี',
              ),

              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'ชื่อจริง (อังกฤษ)',
                filledTextLeft: 'Natthadol',
                labelRight: 'นามสกุล (อังกฤษ)',
                filledTextRight: 'Thavachpongsri',
              ),

              const SizedBox(height: 16),
              _buildProfileTextFieldRow(
                labelLeft: 'เพศ',
                filledTextLeft: 'ชาย',
                labelRight: 'วันเดือนปีเกิด',
                filledTextRight: '09/09/2025',
              ),

              const SizedBox(height: 16),

              _buildProfileTextFieldRow(
                labelLeft: 'สถานที่เกิด',
                filledTextLeft: 'กรุงเทพ',
                labelRight: 'อายุ',
                filledTextRight: '21 ปี',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'อีเมล',
                filledText: 'tester.pgm@gmail.com',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'เบอร์โทรศัพท์มือถือ',
                filledText: '0888888888',
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'ที่อยู่ (ไทย)',
                filledText:
                    '22 ซอย เพชรเกษม 47/2 แขวงบางแค บางแค กรุงเทพมหานคร 10160',
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              _buildProfileTextField(
                label: 'ที่อยู่ (อังกฤษ)',
                filledText:
                    '22 Soi Petchkasem 47/2, Bang Khae Office, Bang Khae, Bangkok 10160',
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTextField({
    required String label,
    required String filledText,
    int? maxLines,
  }) {
    maxLines = maxLines ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          readOnly: true,
          controller: TextEditingController(text: filledText),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),

        ),
      ],
    );
  }

  Widget _buildProfileTextFieldRow({
    required String labelLeft,
    required String filledTextLeft,
    required String labelRight,
    required String filledTextRight,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildProfileTextField(
            label: labelLeft,
            filledText: filledTextLeft,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildProfileTextField(
            label: labelRight,
            filledText: filledTextRight,
          ),
        ),
      ],
    );
  }
}
