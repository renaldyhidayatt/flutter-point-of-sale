import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final bool isTablet;
  final bool isDesktop;
  final bool isLargeDesktop;
  final Function(Map<String, dynamic>) addToCart;

  const ProductGrid({
    Key? key,
    required this.products,
    required this.isTablet,
    required this.isDesktop,
    required this.isLargeDesktop,
    required this.addToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 2; // Default for mobile
    if (isTablet) {
      crossAxisCount = 2;
    } else if (isDesktop || isLargeDesktop) {
      crossAxisCount = 4;
    }

    int itemCount = products.length;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isTablet ? 0.75 : (isDesktop ? 0.7 : 0.8),
          ),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['name'],
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('\$${product['price'].toStringAsFixed(2)}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => addToCart(product),
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
