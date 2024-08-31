import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/pages/pos/CardSummary.dart';
import 'package:flutter_application_1/components/pages/pos/ProductGrid.dart';

class Content extends StatefulWidget {
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
  // ignore: library_private_types_in_public_api
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Map<String, dynamic>> cartItems = [];
  final List<Map<String, dynamic>> products = [
    {'name': 'Product 1', 'price': 21.00, 'image': 'assets/example.png'},
    {'name': 'Product 2', 'price': 33.00, 'image': 'assets/example.png'},
    {'name': 'Product 3', 'price': 54.00, 'image': 'assets/example.png'},
    {'name': 'Product 4', 'price': 43.00, 'image': 'assets/example.png'},
    {'name': 'Product 5', 'price': 20.00, 'image': 'assets/example.png'},
    {'name': 'Product 6', 'price': 35.00, 'image': 'assets/example.png'},
    {'name': 'Product 7', 'price': 50.00, 'image': 'assets/example.png'},
    {'name': 'Product 8', 'price': 45.00, 'image': 'assets/example.png'},
    {'name': 'Product 9', 'price': 21.00, 'image': 'assets/example.png'},
    {'name': 'Product 10', 'price': 34.00, 'image': 'assets/example.png'},
    {'name': 'Product 11', 'price': 56.00, 'image': 'assets/example.png'},
    {'name': 'Product 12', 'price': 46.00, 'image': 'assets/example.png'},
    {'name': 'Product 13', 'price': 27.00, 'image': 'assets/example.png'},
    {'name': 'Product 14', 'price': 38.00, 'image': 'assets/example.png'},
    {'name': 'Product 15', 'price': 59.00, 'image': 'assets/example.png'},
    {'name': 'Product 16', 'price': 49.00, 'image': 'assets/example.png'},
  ];

  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item['product'] == product);
      if (index == -1) {
        cartItems.add({'product': product, 'quantity': 1});
      } else {
        cartItems[index]['quantity'] += 1;
      }
    });
  }

  void _updateQuantity(Map<String, dynamic> product, int newQuantity) {
    setState(() {
      final index = cartItems.indexWhere((item) => item['product'] == product);
      if (index != -1) {
        if (newQuantity <= 0) {
          cartItems.removeAt(index);
        } else {
          cartItems[index]['quantity'] = newQuantity;
        }
      }
    });
  }

  void _removeFromCart(Map<String, dynamic> product) {
    setState(() {
      cartItems.removeWhere((item) => item['product'] == product);
    });
  }

  void _checkout() {
    double totalPrice = cartItems.fold(
      0.0,
      (sum, item) => sum + (item['product']['price'] * item['quantity']),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Checkout'),
          content: Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}\nProceed with payment?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the total price dialog
                setState(() {
                  cartItems.clear();
                });
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: widget.isTablet || widget.isDesktop ? 3 : 2,
            child: ProductGrid(
              products: products,
              isTablet: widget.isTablet,
              isDesktop: widget.isDesktop,
              isLargeDesktop: widget.isLargeDesktop,
              addToCart: _addToCart,
            ),
          ),
          SizedBox(width: 16),
          if (!widget.isTablet && !widget.isDesktop)
            Expanded(
              child: CartSummary(
                cartItems: cartItems,
                updateQuantity: _updateQuantity,
                removeFromCart: _removeFromCart,
                checkout: _checkout,
              ),
            ),
          if (widget.isTablet || widget.isDesktop)
            Container(
              width: 300,
              child: CartSummary(
                cartItems: cartItems,
                updateQuantity: _updateQuantity,
                removeFromCart: _removeFromCart,
                checkout: _checkout,
              ),
            ),
        ],
      ),
    );
  }
}
