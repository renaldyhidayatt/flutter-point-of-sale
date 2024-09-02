import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cartprovider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/components/pages/pos/CardSummary.dart';
import 'package:flutter_application_1/components/pages/pos/ProductGrid.dart';

class Content extends StatelessWidget {
  final bool isTablet;
  final bool isDesktop;
  final bool isLargeDesktop;

  const Content({
    Key? key,
    required this.isTablet,
    required this.isDesktop,
    required this.isLargeDesktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: isTablet || isDesktop ? 3 : 4,
            child: ProductGrid(
              products: [
                {
                  "id": 1,
                  'name': 'Product 1',
                  'price': 10000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 2,
                  'name': 'Product 2',
                  'price': 15000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 3,
                  'name': 'Product 3',
                  'price': 17000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 4,
                  'name': 'Product 4',
                  'price': 20000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 5,
                  'name': 'Product 5',
                  'price': 20000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 6,
                  'name': 'Product 6',
                  'price': 35000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 7,
                  'name': 'Product 7',
                  'price': 50000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 8,
                  'name': 'Product 8',
                  'price': 45000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 9,
                  'name': 'Product 9',
                  'price': 21000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 10,
                  'name': 'Product 10',
                  'price': 34000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 11,
                  'name': 'Product 11',
                  'price': 56000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 12,
                  'name': 'Product 12',
                  'price': 46000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 13,
                  'name': 'Product 13',
                  'price': 27000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 14,
                  'name': 'Product 14',
                  'price': 38000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 15,
                  'name': 'Product 15',
                  'price': 59000,
                  'image': 'assets/example.png'
                },
                {
                   "id": 16,
                  'name': 'Product 16',
                  'price': 49000,
                  'image': 'assets/example.png'
                },
              ],
              isTablet: isTablet,
              isDesktop: isDesktop,
              isLargeDesktop: isLargeDesktop,
              addToCart: (product) => cartProvider.addToCart(product),
            ),
          ),
          const SizedBox(width: 16),
          // Hide CartSummary if in mobile resolution
          if (screenWidth >
              600) // Assuming mobile screen width is less than 600
            if (!isTablet && !isDesktop)
              Expanded(
                child: CartSummary(
                  
                ),
              ),
          if (screenWidth >
              600) // Assuming mobile screen width is less than 600
            if (isTablet || isDesktop)
              Container(
                width: 300,
                child: CartSummary(
                ),
              ),
        ],
      ),
    );
  }
}
