import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  double getTotalPrice(double discount) {
    double totalPrice = _cartItems.fold(
      0.0,
      (sum, item) => sum + (item['product']['price'] * item['quantity']),
    );

    // Calculate discount amount and apply it to totalPrice
    double discountAmount = (totalPrice * discount / 100).toDouble();
    double finalPrice = totalPrice - discountAmount;

    return finalPrice;
  }

  void addToCart(Map<String, dynamic> product) {
    final index = _cartItems.indexWhere((item) => item['product'] == product);
    if (index == -1) {
      _cartItems.add({'product': product, 'quantity': 1});
    } else {
      _cartItems[index]['quantity'] += 1;
    }
    notifyListeners();
  }

  void updateQuantity(Map<String, dynamic> product, int newQuantity) {
    final index = _cartItems.indexWhere((item) => item['product'] == product);
    if (index != -1) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index]['quantity'] = newQuantity;
      }
      notifyListeners();
    }
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['product'] == product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
