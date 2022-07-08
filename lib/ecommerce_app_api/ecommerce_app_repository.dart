import 'package:simple_ecommerce_app/ecommerce_app_api/api/ecommerce_api.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';

class EccommerceRepository {
  final EcommerceApi _api;
  EccommerceRepository({required EcommerceApi api}) : _api = api;

  List<CartItem> getCartItems() => _api.getCartItems();

  Future<void> addCartItem(CartItem cartItem) async => await _api.addToCart(cartItem);

  Future<void> removeCartItem(CartItem cartItem) async => await _api.removeFromCart(cartItem);

  Future<void> clearCart() async => await _api.clearCart();

  Future<void> updateCart(List<CartItem> cartItems) async => await _api.updateCart(cartItems);
}
