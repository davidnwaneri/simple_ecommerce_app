import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/product/dummy_products.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/product/product_model.dart';
import 'package:simple_ecommerce_app/features/blocs/cart/cart_bloc.dart';
import 'package:simple_ecommerce_app/features/presentation/cart/cart_page.dart';
import 'package:simple_ecommerce_app/features/presentation/product/product_card.dart';

class ProductListPage extends StatelessWidget {
  static const id = 'product_list_page';
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProductView();
  }
}

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: const [
          CartIcon(),
          SizedBox(width: 8),
        ],
      ),
      body: const SafeArea(
        child: ProductGridView(),
      ),
    );
  }
}

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = context.select<CartBloc, int>((bloc) => bloc.state.cartCount);
    return Badge(
      showBadge: count > 0,
      toAnimate: false,
      badgeColor: Colors.orange,
      position: const BadgePosition(top: 0, end: 0),
      badgeContent: Text('$count'),
      child: IconButton(
        icon: Icon(count > 0 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
        onPressed: () => Navigator.pushNamed(context, CartPage.id),
      ),
    );
  }
}

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
  }) : super(key: key);

  final List<Product> products = DummyProducts.products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 150 / 230,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
