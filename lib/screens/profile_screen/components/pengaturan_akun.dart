import 'package:flutter/material.dart';

class PengaturanAkun extends StatelessWidget {
  const PengaturanAkun({super.key});

  static const _pengaturanAkun = [
    {'title': 'Daftar Alamat', 'subtitle': 'Atur alamat pengiriman belanjaan'},
    {
      'title': 'Rekening Bank',
      'subtitle': 'Tarik Saldo MarketNest ke rekening tujuan'
    },
    {
      'title': 'Pembayaran Instan',
      'subtitle': 'E-wallet, kartu kredit, & debit instan terdaftar'
    },
    {
      'title': 'Keamanan Akun',
      'subtitle': 'Kata sandi, PIN, & verifiaksi data diri'
    },
    {'title': 'Notifikasi', 'subtitle': 'Atur segala jenis pesan notifikasi'},
    {
      'title': 'Privasi Akun',
      'subtitle': 'Atur penggunaan data pribadimu di MarketNest'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan Akun',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          pengaturanAkunList(),
        ],
      ),
    );
  }

  Widget pengaturanAkunList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pengaturanAkun.length,
      itemBuilder: (context, index) {
        return textBuild(
          title: _pengaturanAkun[index]['title']!,
          subtitle: _pengaturanAkun[index]['subtitle']!,
        );
      },
    );
  }

  Widget textBuild({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            height: 1,
            color: Color(0xff6D6D6D),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
