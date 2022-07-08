import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/product/product_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/ecommerce_app_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final EccommerceRepository _repository;

  bool isProductInCart(Product product) {
    return state.items.map((e) => e.product).toList().contains(product);
  }

  double getTotalPrice() {
    return state.items.fold(0, (previousValue, element) {
      return previousValue + element.product.price * element.quantity;
    });
  }

  CartBloc({required EccommerceRepository repository})
      : _repository = repository,
        super(const CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
    on<LoadCartItems>(_onLoadCartItems);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  void _onLoadCartItems(LoadCartItems event, Emitter<CartState> emit) {
    emit(const CartLoading());
    final items = _repository.getCartItems();
    emit(CartLoaded(items: items));
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final newCartList = <CartItem>[...state.items];
    if (newCartList.contains(event.cartItem)) {
      add(RemoveFromCart(cartItem: event.cartItem));
    } else {
      await _repository.addCartItem(event.cartItem);
      newCartList.add(event.cartItem);

      emit(CartLoaded(items: newCartList));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    final newCartList = <CartItem>[...state.items];
    if (newCartList.contains(event.cartItem)) {
      await _repository.removeCartItem(event.cartItem);
      newCartList.remove(event.cartItem);
      emit(CartLoaded(items: newCartList));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    await _repository.clearCart();
    emit(const CartInitial(items: []));
  }

  Future<void> _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) async {
    final items = <CartItem>[...state.items];
    final CartItem item = items.firstWhere((e) => e.product == event.cartItem.product);
    final int index = items.indexOf(item);
    items.remove(item);
    final newitem = item.copyWith(quantity: item.quantity + 1);
    items.insert(index, newitem);
    await _repository.updateCart(items);
    emit(CartLoaded(items: items));
  }

  Future<void> _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) async {
    if (event.cartItem.quantity > 1) {
      final items = <CartItem>[...state.items];
      final CartItem item = items.firstWhere((e) => e.product == event.cartItem.product);
      final int index = items.indexOf(item);
      items.remove(item);
      final newitem = item.copyWith(quantity: item.quantity - 1);
      items.insert(index, newitem);
      await _repository.updateCart(items);
      emit(CartLoaded(items: items));
    }
  }
}
