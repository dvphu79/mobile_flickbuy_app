import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:mobile_flickbuy_app/src/features/cart/data/local_cart_repository.dart';
import 'package:mobile_flickbuy_app/src/features/cart/domain/cart_item.dart';
import 'package:mobile_flickbuy_app/src/routing/app_router.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [CartItemSchema], // Add your Isar schemas here
    directory: dir.path,
  );
  runApp(
    ProviderScope(
      overrides: [
        // Override the isarProvider with the initialized Isar instance
        isarProvider.overrideWithValue(isar),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'FlickBuy',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
    );
  }
}
