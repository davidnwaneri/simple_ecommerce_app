import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_theme.dart';
import 'package:simple_ecommerce_app/features/blocs/cart/cart_bloc.dart';
import 'package:simple_ecommerce_app/features/presentation/cart/cart_item_card.dart';

class CartPage extends StatelessWidget {
  static const id = 'cart_page';
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
        actions: [
          TextButton.icon(
            onPressed: () => _clearCart(context),
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Clear'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: const SafeArea(
        child: CartView(),
      ),
    );
  }

  void _clearCart(BuildContext context) {
    context.read<CartBloc>().add(const ClearCart());
  }
}

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 16),
        const TotalPrice(),
        const SizedBox(height: 8),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cartItems = state.items;
            return CartListView(
              cartItems: cartItems,
            );
          },
        ),
        ElevatedButton.icon(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10),
                ),
              ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Proceed to checkout'),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart_checkout),
          label: const Text('Chekout'),
        ),
      ],
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.select((CartBloc bloc) => bloc.state.cartTotal);
    if (totalPrice == 0) {
      return const SizedBox();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Sub Total:', style: EcommerceAppTheme.darkTextTheme.bodyText1),
        Text('\$$totalPrice', style: EcommerceAppTheme.darkTextTheme.bodyText1),
      ],
    );
  }
}

class CartListView extends StatelessWidget {
  const CartListView({
    Key? key,
    required this.cartItems,
  }) : super(key: key);

  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return const Center(
        child: Text('Your cart is empty'),
      );
    }
    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return CartItemCard(
            cartItem: cartItems[index],
          );
        },
      ),
    );
  }
}
