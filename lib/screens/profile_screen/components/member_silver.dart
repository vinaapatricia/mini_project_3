import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/profile_screen/components/custom_card.dart';

class MemberSilver extends StatelessWidget {
  const MemberSilver({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: 'Member Silver',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconBuild(
            image: 'Document.png',
            title: 'Toko Member',
            subtitle: '4 Toko',
          ),
          iconBuild(
            image: 'Document.png',
            title: 'Misi Seru',
            subtitle: '4 Tantangan',
          ),
          iconBuild(
            image: 'Document.png',
            title: 'Kupon Saya',
            subtitle: '15 Kupon',
          ),
        ],
      ),
    );
  }

  Widget iconBuild({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Image.asset(
          'assets/icons/$image',
          width: 24,
          height: 24,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff6D787A),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
