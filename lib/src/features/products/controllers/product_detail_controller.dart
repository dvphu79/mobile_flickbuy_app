import 'package:mobile_flickbuy_app/src/features/products/data/products_repository.dart';
import 'package:mobile_flickbuy_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_detail_controller.g.dart';

@riverpod
class ProductDetailController extends _$ProductDetailController {
  @override
  Future<Product> build(String productId) async {
    final productsRepository = ref.watch(productsRepositoryProvider);
    return productsRepository.fetchProduct(productId);
  }
}
