import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/features/cart/controllers/cart_controller.dart';
import 'package:mobile_flickbuy_app/src/features/cart/domain/cart_item.dart';
import 'package:mobile_flickbuy_app/src/features/cart/presentation/cart_list_item.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsyncValue = ref.watch(cartControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: cartAsyncValue.when(
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is currently empty.'));
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartListItem(item: item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error loading cart: $error')),
      ),
    );
  }
}
