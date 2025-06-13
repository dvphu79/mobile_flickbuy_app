import 'package:isar/isar.dart';
import 'package:mobile_flickbuy_app/src/features/cart/domain/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_cart_repository.g.dart';

class LocalCartRepository {
  LocalCartRepository(this._isar);
  final Isar _isar;

  Future<List<CartItem>> fetchCart() async {
    return _isar.cartItems.where().findAll();
  }

  Future<void> addItem(CartItem item) async {
    await _isar.writeTxn(() async {
      await _isar.cartItems.put(item);
    });
  }

  Future<void> removeItem(String productId) async {
    await _isar.writeTxn(() async {
      await _isar.cartItems.filter().productIdEqualTo(productId).deleteAll();
    });
  }

  Future<void> updateItemQuantity(String productId, int newQuantity) async {
    await _isar.writeTxn(() async {
      final cartItem =
          await _isar.cartItems
              .filter()
              .productIdEqualTo(productId)
              .findFirst();
      if (cartItem != null) {
        if (newQuantity > 0) {
          cartItem.quantity = newQuantity;
          await _isar.cartItems.put(cartItem);
        } else {
          await _isar.cartItems.delete(cartItem.id);
        }
      }
    });
  }

  Future<void> clearCart() async {
    await _isar.writeTxn(() async {
      await _isar.cartItems.clear();
    });
  }
}

// Provider for the Isar instance (assuming Isar is initialized elsewhere and provided)
final isarProvider = Provider<Isar>(
  (ref) => throw UnimplementedError("Isar instance not provided"),
);

@riverpod
LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  return LocalCartRepository(ref.watch(isarProvider));
}
