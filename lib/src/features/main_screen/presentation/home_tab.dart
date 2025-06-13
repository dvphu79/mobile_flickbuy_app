import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_flickbuy_app/src/features/cart/controllers/cart_controller.dart';
import 'package:mobile_flickbuy_app/src/features/products/controllers/products_controller.dart';
import 'package:mobile_flickbuy_app/src/features/products/presentation/product_card.dart';
import 'package:mobile_flickbuy_app/src/routing/app_router.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Consumer(
            builder: (context, ref, child) => _buildCartIcon(context, ref),
          ),
        ],
      ),
      body: productsAsyncValue.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75, // Adjust as needed for your card layout
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(productsControllerProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartIcon(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    final totalItems = cartState.maybeWhen(
      data: (items) => items.fold(0, (sum, item) => sum + item.quantity),
      orElse: () => 0,
    );

    return Badge(
      label: Text('$totalItems'),
      alignment: AlignmentDirectional.topStart,
      isLabelVisible: totalItems > 0,
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          context.pushNamed(AppRoute.cart.name);
        },
      ),
    );
  }
}
