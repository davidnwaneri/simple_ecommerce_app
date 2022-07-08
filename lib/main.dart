import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/api/local_storage_api.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/ecommerce_app_repository.dart';
import 'package:simple_ecommerce_app/ecommerce_app_theme.dart';
import 'package:simple_ecommerce_app/features/blocs/cart/cart_bloc.dart';
import 'package:simple_ecommerce_app/features/presentation/cart/cart_page.dart';
import 'package:simple_ecommerce_app/features/presentation/product/product_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    EcommerceApp(
      api: LocalStorageEcommerceApi(
        preferences: await SharedPreferences.getInstance(),
      ),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key, required this.api}) : super(key: key);
  final LocalStorageEcommerceApi api;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => EccommerceRepository(
        api: api,
      ),
      child: const EcommerceAppView(),
    );
  }
}

class EcommerceAppView extends StatelessWidget {
  const EcommerceAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(
        repository: context.read<EccommerceRepository>(),
      )..add(const LoadCartItems()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce',
        theme: EcommerceAppTheme.darkTheme(),
        initialRoute: ProductListPage.id,
        routes: {
          ProductListPage.id: (context) => const ProductListPage(),
          CartPage.id: (context) => const CartPage(),
        },
      ),
    );
  }
}
