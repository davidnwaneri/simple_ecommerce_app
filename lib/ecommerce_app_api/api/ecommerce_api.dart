import 'dart:async';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';

abstract class EcommerceApi {
  const EcommerceApi();

  List<CartItem> getCartItems();
  Future<void> addToCart(CartItem cartItem);
  Future<void> removeFromCart(CartItem cartItem);
  Future<void> clearCart();
  Future<void> updateCart(List<CartItem> cartItems);

  int get cartItemsCount => getCartItems().length;
}
