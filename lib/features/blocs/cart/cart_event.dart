part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCartItems extends CartEvent {
  const LoadCartItems();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem cartItem;
  const AddToCart({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class RemoveFromCart extends CartEvent {
  final CartItem cartItem;
  const RemoveFromCart({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class ClearCart extends CartEvent {
  const ClearCart();
}

class IncreaseQuantity extends CartEvent {
  final CartItem cartItem;
  const IncreaseQuantity({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}

class DecreaseQuantity extends CartEvent {
  final CartItem cartItem;
  const DecreaseQuantity({required this.cartItem});

  @override
  List<Object> get props => [cartItem];
}
