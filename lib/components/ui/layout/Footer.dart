import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menentukan apakah perangkat adalah mobile
    bool isMobile = MediaQuery.of(context).size.width < 600;
    bool isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    // Jika perangkat adalah mobile, footer tidak akan ditampilkan
    if (isMobile || isTablet) {
      return const SizedBox.shrink();
    }

    // Footer hanya akan ditampilkan jika perangkat bukan mobile
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      decoration: BoxDecoration(
        color: Colors.white, // Memindahkan color ke dalam BoxDecoration
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna bayangan
            spreadRadius: 1, // Radius sebaran bayangan
            blurRadius: 5, // Radius blur bayangan
            offset: Offset(0, 3), // Posisi bayangan (x, y)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '© 2024 Sanedge',
            style: TextStyle(color: Colors.black),
          ),
          // Row(
          //   children: [
          //     TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Privacy Policy',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //     const SizedBox(width: 16),
          //     TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Terms of Service',
          //         style: TextStyle(color: Colors.black),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
