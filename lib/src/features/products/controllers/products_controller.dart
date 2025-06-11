import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/features/products/data/products_repository.dart';
import 'package:mobile_flickbuy_app/src/features/products/domain/product.dart';

final productsControllerProvider =
    AsyncNotifierProvider<ProductsController, List<Product>>(
      () => ProductsController(),
    );

class ProductsController extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() {
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() =>
      ref.read(productsRepositoryProvider).fetchProducts();
}
