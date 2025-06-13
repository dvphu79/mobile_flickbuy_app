import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/features/cart/controllers/cart_controller.dart';
import 'package:mobile_flickbuy_app/src/features/cart/domain/cart_item.dart';

class CartListItem extends ConsumerWidget {
  const CartListItem({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartController = ref.read(cartControllerProvider.notifier);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product ID: ${item.productId}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text('Quantity: ${item.quantity}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed:
                  item.quantity > 1
                      ? () => cartController.updateQuantity(
                        item.productId,
                        item.quantity - 1,
                      )
                      : null, // Disable if quantity is 1, user should use delete
            ),
            Text(
              '${item.quantity}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed:
                  () => cartController.updateQuantity(
                    item.productId,
                    item.quantity + 1,
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => cartController.removeFromCart(item.productId),
            ),
          ],
        ),
      ),
    );
  }
}
