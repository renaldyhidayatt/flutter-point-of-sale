import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/cartprovider.dart';
import 'package:provider/provider.dart';

class CartSummary extends StatelessWidget {
  final double discount;

  const CartSummary({
    Key? key,
    this.discount = 10.0, // Default discount to 10.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobileOrTablet = screenWidth < 600;

    // Define sizes based on screen width
    double padding = 12.0;
    double titleFontSize = 18.0;
    double itemFontSize = 20.0;
    double totalFontSize = 20.0;
    double buttonFontSize = 20.0;
    double buttonHeight = 42.0;

    if (screenWidth < 300) {
      padding = 4.0;
      titleFontSize = 14.0;
      itemFontSize = 12.0;
      totalFontSize = 14.0;
      buttonFontSize = 12.0;
      buttonHeight = 30.0;
    } else if (screenWidth < 400) {
      padding = 8.0;
      titleFontSize = 16.0;
      itemFontSize = 18.0;
      totalFontSize = 18.0;
      buttonFontSize = 18.0;
      buttonHeight = 36.0;
    } else if (screenWidth < 500) {
      padding = 10.0;
      titleFontSize = 18.0;
      itemFontSize = 18.0;
      totalFontSize = 18.0;
      buttonFontSize = 18.0;
      buttonHeight = 36.0;
    } else if (screenWidth < 600) {
      padding = 12.0;
      titleFontSize = 18.0;
      itemFontSize = 20.0;
      totalFontSize = 20.0;
      buttonFontSize = 20.0;
      buttonHeight = 42.0;
    }

    double totalPrice =
        cartProvider.getTotalPrice(0); // Get total price without discount
    double discountAmount = (totalPrice * this.discount / 100).toDouble();
    double finalPrice = totalPrice - discountAmount;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Riwayat Pembelian',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Set text color to black
          ),
        ),
        SizedBox(height: padding),
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              final product = cartItem['product'];
              final quantity = cartItem['quantity'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      width: screenWidth < 300 ? 20 : 30,
                      height: screenWidth < 300 ? 20 : 30,
                    ),
                    SizedBox(width: padding / 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              fontSize: itemFontSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black, // Set text color to black
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Rp.${product['price'].toStringAsFixed(0)} x $quantity',
                            style: TextStyle(
                              fontSize: itemFontSize * 0.85,
                              color: Colors.black, // Set text color to black
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
                          onPressed: () => cartProvider.updateQuantity(
                              product, quantity - 1),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: itemFontSize),
                          onPressed: () => cartProvider.updateQuantity(
                              product, quantity + 1),
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
            color: Colors.black, // Set text color to black
          ),
        ),
        SizedBox(height: padding / 2),
        Text(
          'Discount (${discount.toStringAsFixed(0)}%): -Rp.${discountAmount.toStringAsFixed(0)}',
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
            color: Colors.black, // Set text color to black
          ),
        ),
        SizedBox(height: padding / 2),
        SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: () {
              // Trigger checkout process
              _checkout(context);
            },
            child: Text(
              'Checkout',
              style: TextStyle(fontSize: buttonFontSize),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black, // Set button text color to white
            ),
          ),
        ),
      ],
    );

    return Card(
      elevation: 4,
      color: Colors.white, // Set card color to white
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: isMobileOrTablet
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: screenWidth < 600
                      ? 600
                      : double.infinity, // Minimum width for content
                  child: content,
                ),
              )
            : content,
      ),
    );
  }

  void _checkout(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double totalPrice =
        cartProvider.getTotalPrice(0); // Get total price without discount
    double discountAmount = (totalPrice * this.discount / 100).toDouble();
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
