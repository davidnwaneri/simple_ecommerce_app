import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_ecommerce_app/ecommerce_app_api/model/product/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
