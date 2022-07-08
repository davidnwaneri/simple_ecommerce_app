part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  const CartState({required this.items});
  final List<CartItem> items;

  int get cartCount => items.length;
  double get cartTotal => items.fold(0, (total, item) => total + item.product.price * item.quantity);

  @override
  List<Object> get props => [items];

  @override
  bool get stringify => true;
}

class CartInitial extends CartState {
  const CartInitial({super.items = const []});
}

class CartLoading extends CartState {
  const CartLoading({super.items = const []});
}

class CartLoaded extends CartState {
  const CartLoaded({required super.items});
}

class CartError extends CartState {
  const CartError({super.items = const [], required this.error});
  final String error;
}
