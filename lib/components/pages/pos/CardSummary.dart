import 'package:flutter/material.dart';


class CartSummary extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Map<String, dynamic>, int) updateQuantity;
  final Function(Map<String, dynamic>) removeFromCart;
  final VoidCallback checkout;

  const CartSummary({
    Key? key,
    required this.cartItems,
    required this.updateQuantity,
    required this.removeFromCart,
    required this.checkout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
        bool isDesktop = constraints.maxWidth >= 900 && constraints.maxWidth < 1200;
        bool isLargeDesktop = constraints.maxWidth >= 1200;

        double totalPrice = cartItems.fold(
          0.0,
          (sum, item) => sum + (item['product']['price'] * item['quantity']),
        );

        double padding = isMobile ? 8.0 : (isTablet ? 12.0 : 16.0);
        double titleFontSize = isMobile ? 16.0 : (isTablet ? 18.0 : 20.0);
        double itemFontSize = isMobile ? 14.0 : (isTablet ? 20.0 : 25.0);
        double totalFontSize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
        double buttonFontSize = isMobile ? 14.0 : (isTablet ? 16.0 : 18.0);
        double buttonHeight = isMobile ? 36.0 : (isTablet ? 40.0 : 48.0);

        return Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Purchase History',
                  style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: padding),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      final product = cartItem['product'];
                      final quantity = cartItem['quantity'];

                      return ListTile(
                        leading: Image.asset(
                          product['image'],
                          fit: BoxFit.cover,
                          width: isMobile ? 40 : 50,
                          height: isMobile ? 40 : 50,
                        ),
                        title: Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: itemFontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          '\$${product['price'].toStringAsFixed(2)} x $quantity',
                          style: TextStyle(fontSize: itemFontSize * 0.85),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: itemFontSize * 0.85),
                              onPressed: () => updateQuantity(product, quantity - 1),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, size: itemFontSize * 0.85),
                              onPressed: () => updateQuantity(product, quantity + 1),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: itemFontSize * 0.85),
                              onPressed: () => removeFromCart(product),
                            ),
                          ],
                        ),
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                      );
                    },
                  ),
                ),
                Divider(),
                SizedBox(height: 8),
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: totalFontSize, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: padding),
                ElevatedButton(
                  onPressed: checkout,
                  child: Text(
                    'Checkout',
                    style:  TextStyle(fontSize: buttonFontSize),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, buttonHeight),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
