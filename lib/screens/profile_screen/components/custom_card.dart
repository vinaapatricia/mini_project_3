import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final String? header;
  final bool? isHasMore;

  const CustomCard({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(8),
    this.header,
    this.isHasMore = false,
  });

  _buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              header!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (isHasMore == true)
              const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color(0xff00AA5B),
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) _buildHeader(),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xffD5D9E2)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}
