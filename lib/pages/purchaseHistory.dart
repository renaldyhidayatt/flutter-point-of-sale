import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cartprovider.dart';
import 'package:provider/provider.dart';

class PurchaseHistoryPage extends StatefulWidget {
  final double discount;

   PurchaseHistoryPage({
    Key? key,
    this.discount = 10.0, // Default discount
  }) : super(key: key);

  @override
  _PurchaseHistoryPageState createState() => _PurchaseHistoryPageState();
}

class _PurchaseHistoryPageState extends State<PurchaseHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    double screenWidth = MediaQuery.of(context).size.width;

    // Define sizes based on screen width
    double padding = 16.0;
    double imageSize = 50.0;
    double titleFontSize = 18.0;
    double itemFontSize = 18.0;
    double totalFontSize = 18.0;
    double buttonFontSize = 16.0;
    double buttonHeight = 40.0;
    double buttonWidth = 40.0;

    if (screenWidth < 600) {
      // Mobile
      padding = 8.0;
      imageSize = 40.0;
      titleFontSize = 16.0;
      itemFontSize = 18.0;
      totalFontSize = 18.0;
      buttonFontSize = 14.0;
      buttonHeight = 36.0;
      buttonWidth = 205.0;
    } else if (screenWidth < 900) {
      // Tablet
      padding = 12.0;
      imageSize = 45.0;
      titleFontSize = 16.0;
      itemFontSize = 18.0;
      totalFontSize = 16.0;
      buttonFontSize = 15.0;
      buttonHeight = 38.0;
      buttonWidth = 215.0;
    } else if (screenWidth < 1200) {
      // Desktop
      padding = 16.0;
      imageSize = 50.0;
      titleFontSize = 16.0;
      itemFontSize = 22.0;
      totalFontSize = 18.0;
      buttonFontSize = 16.0;
      buttonHeight = 40.0;
      buttonWidth = 220.0;
    } else {
      // Large Desktop
      padding = 20.0;
      imageSize = 60.0;
      titleFontSize = 18.0;
      itemFontSize = 24.0;
      totalFontSize = 20.0;
      buttonFontSize = 18.0;
      buttonHeight = 45.0;
      buttonWidth = 225.0;
    }

    double totalPrice = cartProvider.getTotalPrice(0); // Get total price without discount
    double discountAmount = (totalPrice * widget.discount / 100).toDouble();
    double finalPrice = totalPrice - discountAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembelian'),
      ),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartProvider.cartItems[index];
                  final product = cartItem['product'];
                  final quantity = cartItem['quantity'];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: padding / 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          product['image'],
                          width: imageSize,
                          height: imageSize,
                        ),
                        SizedBox(width: padding / 2),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Rp.${product['price'].toStringAsFixed(0)} x $quantity',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: itemFontSize),
                              onPressed: () =>
                                  cartProvider.updateQuantity(product, quantity - 1),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, size: itemFontSize),
                              onPressed: () =>
                                  cartProvider.updateQuantity(product, quantity + 1),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: itemFontSize),
                              color: Colors.red,
                              onPressed: () => cartProvider.removeFromCart(product),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            SizedBox(height: padding / 2),
            Text(
              'Subtotal: Rp.${totalPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: totalFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: padding / 2),
            Text(
              'Discount (${widget.discount.toStringAsFixed(0)}%): -Rp.${discountAmount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: totalFontSize,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: padding / 2),
            Text(
              'Total: Rp.${finalPrice.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: totalFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: padding),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () => _checkout(context),
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: buttonFontSize),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  backgroundColor: Colors.black, // Set button color
                  foregroundColor: Colors.white, // Set text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkout(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double totalPrice = cartProvider.getTotalPrice(0); // Get total price without discount
    double discountAmount = (totalPrice * widget.discount / 100).toDouble();
    double finalPrice = totalPrice - discountAmount;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Checkout'),
          content: Text(
              'Total Price: Rp.${finalPrice.toStringAsFixed(0)}\nDiscount: Rp.${discountAmount.toStringAsFixed(0)}\nProceed with payment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                cartProvider.clearCart(); // Clear the cart items
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
