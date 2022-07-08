import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_theme.dart';
import 'package:simple_ecommerce_app/features/blocs/cart/cart_bloc.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1, 1), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 120,
                  height: 110,
                  child: Image.asset(cartItem.product.imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: EcommerceAppTheme.lightTextTheme.bodyText1,
                  ),
                  Text(
                    '\$${cartItem.product.price}',
                    style: EcommerceAppTheme.lightTextTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ),
                onPressed: () => _removeCartItem(context),
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Theme.of(context).textTheme.button!.color,
                ),
                label: Text('Remove', style: Theme.of(context).textTheme.button),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CartItemQuantityButton(
                    icon: Icons.remove,
                    onPressed: () => _decreaseQuantity(context),
                  ),
                  const SizedBox(width: 4),
                  CartItemQuantity(cartItem: cartItem),
                  const SizedBox(width: 4),
                  CartItemQuantityButton(
                    icon: Icons.add,
                    onPressed: () => _increaseQuantity(context),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _removeCartItem(BuildContext context) {
    context.read<CartBloc>().add(RemoveFromCart(cartItem: cartItem));
  }

  void _increaseQuantity(BuildContext context) {
    context.read<CartBloc>().add(IncreaseQuantity(cartItem: cartItem));
  }

  void _decreaseQuantity(BuildContext context) {
    context.read<CartBloc>().add(DecreaseQuantity(cartItem: cartItem));
  }
}

class CartItemQuantity extends StatelessWidget {
  const CartItemQuantity({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    int quantity = context.select((CartBloc bloc) => bloc.state).items.firstWhere((item) => item.product.id == cartItem.product.id).quantity;
    return Text('$quantity', style: EcommerceAppTheme.lightTextTheme.bodyText2);
  }
}

class CartItemQuantityButton extends StatelessWidget {
  const CartItemQuantityButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}
