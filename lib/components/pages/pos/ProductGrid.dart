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
    int crossAxisCount;
    double childAspectRatio;
    double padding;
    bool isMobile = MediaQuery.of(context).size.width < 600;

    // Determine layout based on screen size
    if (MediaQuery.of(context).size.width < 400) {
      // Very small mobile layout
      crossAxisCount = 1;
      childAspectRatio = 0.85;
      padding = 8.0;
    } else if (MediaQuery.of(context).size.width < 600) {
      // Mobile layout
      crossAxisCount = 2;
      childAspectRatio = 0.75;
      padding = 8.0;
    } else if (isTablet) {
      // Tablet layout
      crossAxisCount = 3;
      childAspectRatio = 0.7;
      padding = 16.0;
    } else if (isDesktop || isLargeDesktop) {
      // Desktop layout
      crossAxisCount = 4;
      childAspectRatio = 0.65;
      padding = 16.0;
    } else {
      // Default fallback
      crossAxisCount = 2;
      childAspectRatio = 0.75;
      padding = 8.0;
    }

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      child: Scrollbar(
        thumbVisibility: true,
        child: GridView.builder(
          padding: EdgeInsets.all(padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: padding,
            mainAxisSpacing: padding,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Align(
              alignment: isMobile ? Alignment.center : Alignment.topLeft,
              child: SizedBox(
                width:
                    isMobile ? MediaQuery.of(context).size.width * 0.9 : null,
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4)),
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          product['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Rp.${product['price'].toStringAsFixed(0)}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => addToCart(product),
                            child: const Text('Add to Cart'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
