import 'package:mobile_flickbuy_app/src/features/cart/data/local_cart_repository.dart';
import 'package:mobile_flickbuy_app/src/features/cart/domain/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  LocalCartRepository get _cartRepository =>
      ref.read(localCartRepositoryProvider);

  @override
  Future<List<CartItem>> build() async {
    return _cartRepository.fetchCart();
  }

  Future<void> addToCart(String productId) async {
    state = const AsyncLoading();
    try {
      final currentCart = await _cartRepository.fetchCart(); // Fetch fresh cart
      final existingItemIndex = currentCart.indexWhere(
        (item) => item.productId == productId,
      );

      if (existingItemIndex != -1) {
        final itemToUpdate = currentCart[existingItemIndex];
        await _cartRepository.updateItemQuantity(
          productId,
          itemToUpdate.quantity + 1,
        );
      } else {
        final newItem =
            CartItem()
              ..productId = productId
              ..quantity = 1;
        await _cartRepository.addItem(newItem);
      }
      state = AsyncData(await _cartRepository.fetchCart());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> removeFromCart(String productId) async {
    state = const AsyncLoading();
    try {
      await _cartRepository.removeItem(productId);
      state = AsyncData(await _cartRepository.fetchCart());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    state = const AsyncLoading();
    try {
      await _cartRepository.updateItemQuantity(productId, newQuantity);
      state = AsyncData(await _cartRepository.fetchCart());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> clearCart() async {
    state = const AsyncLoading();
    try {
      await _cartRepository.clearCart();
      state = AsyncData(await _cartRepository.fetchCart());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
