import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/cart/cart_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/product/product_model.dart';
import 'package:simple_ecommerce_app/ecommerce_app_theme.dart';
import 'package:simple_ecommerce_app/features/blocs/cart/cart_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 230,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Text(product.name, style: EcommerceAppTheme.lightTextTheme.bodyText1),
          Text('\$${product.price}', style: EcommerceAppTheme.lightTextTheme.subtitle1),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  onPressed: () => _addToCart(context),
                  child: Builder(builder: (context) {
                    bool productIsInCart = context.select<CartBloc, bool>((bloc) => bloc.isProductInCart(product));
                    return Icon(
                      productIsInCart ? Icons.shopping_cart : Icons.add_shopping_cart,
                    );
                  }),
                  // label: const Text('Remove'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context) {
    final cartItem = CartItem(product: product);
    context.read<CartBloc>().add(AddToCart(cartItem: cartItem));
  }
}
