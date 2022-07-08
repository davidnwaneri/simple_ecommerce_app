import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/api/ecommerce_api.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';
import 'dart:convert';

class LocalStorageEcommerceApi implements EcommerceApi {
  LocalStorageEcommerceApi({
    required SharedPreferences preferences,
  }) : _prefs = preferences;

  final SharedPreferences _prefs;

  static const _cartItemsKey = 'cartItems';

  Future<void> _setCartItem(String key, String value) async => await _prefs.setString(key, value);
  String? _getCartItem(String key) => _prefs.getString(key);

  @override
  List<CartItem> getCartItems() {
    final encodedString = _getCartItem(_cartItemsKey);
    final List cartItems = encodedString != null ? json.decode(encodedString) : [];
    if (cartItems.isEmpty) return [];
    return cartItems.map((e) => CartItem.fromJson(e)).toList();
  }

  @override
  Future<void> addToCart(CartItem cartItem) async {
    final encodedString = _getCartItem(_cartItemsKey);
    final List cartItems = encodedString != null ? json.decode(encodedString) : [];
    final newCartList = <Map<String, dynamic>>[...cartItems];
    newCartList.add(cartItem.toJson());
    await _setCartItem(_cartItemsKey, json.encode(newCartList));
  }

  @override
  Future<void> removeFromCart(CartItem cartItem) async {
    final encodedString = _getCartItem(_cartItemsKey);
    final List cartItems = encodedString != null ? json.decode(encodedString) : [];
    final newCartList = <Map<String, dynamic>>[...cartItems];
    final item = cartItem.toJson();
    newCartList.removeWhere((e) => e['product']['id'] == item['product']['id']);
    await _setCartItem(_cartItemsKey, json.encode(newCartList));
  }

  @override
  Future<void> clearCart() async {
    // await _setCartItem(_cartItemsKey, '[]');
    _prefs.remove(_cartItemsKey);
  }

  @override
  Future<void> updateCart(List<CartItem> cartItems) async {
    await _setCartItem(_cartItemsKey, json.encode(cartItems));
  }

/// this was the original code to update the cart WHEN an item quantity was increased
/// since i would have to duplicate the code to update the cart when an item quantity was decreased
/// i decided to use the code above to update the cart when an item quantity was increased or decreased
  // @override
  // Future<void> updateCart(CartItem cartItem) async {
  //   final encodedString = _getCartItem(_cartItemsKey);
  //   final List cartItems = encodedString != null ? json.decode(encodedString) : [];
  //   final newCartList = <Map<String, dynamic>>[...cartItems];
  //   final item = cartItem.toJson();
  //   final int index = newCartList.indexWhere((e) => e['product']['id'] == item['product']['id']);
  //   newCartList.removeWhere((e) => e['product']['id'] == item['product']['id']);
  //   newCartList.insert(index, item);
  //   await _setCartItem(_cartItemsKey, json.encode(newCartList));
  // }

  @override
  int get cartItemsCount => getCartItems().length;
}
