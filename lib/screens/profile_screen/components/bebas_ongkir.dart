import 'package:flutter/material.dart';
import 'package:mini_project_3/screens/profile_screen/components/custom_card.dart';

class BebasOngkir extends StatelessWidget {
  const BebasOngkir({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/image55.png',
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nikmatin Bebas Ongkir tanpa batas!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Min. belanja Rp. 0, bebas biaya aplikasi!',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff8F95A1),
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
