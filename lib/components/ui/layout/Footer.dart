import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Menentukan apakah perangkat adalah mobile, tablet, desktop, atau large desktop
    bool isMobile = MediaQuery.of(context).size.width < 600;

    // Jika perangkat adalah mobile, footer tidak akan ditampilkan
    if (isMobile) {
      return const SizedBox.shrink();
    }

    // Footer hanya akan ditampilkan jika perangkat bukan mobile
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      color: Colors.grey[800],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '© 2024 Sanedge',
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
