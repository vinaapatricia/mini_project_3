import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/profile_screen/components/custom_card.dart';

class SaldoPoints extends StatelessWidget {
  const SaldoPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      header: 'Saldo & Points',
      isHasMore: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconBuild(
            image: 'image54.png',
            title: 'Rp. 0',
            subtitle: 'Top-Up Gopay',
          ),
          iconBuild(
            image: 'Document.png',
            title: 'Daftar Sekarang',
            subtitle: 'Top-Up Gopay',
          ),
          iconBuild(
            image: 'Document.png',
            title: 'Rp. 0',
            subtitle: 'Saldo MarketNest',
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
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff6D787A),
          ),
        ),
      ],
    );
  }
}
