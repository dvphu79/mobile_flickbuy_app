import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/common_widgets/my_home_page.dart';

// 1. Define a provider
// This provider will hold an integer, our counter's state.
final counterProvider = StateProvider<int>((ref) => 0);

void main() {
  // 2. Wrap your MyApp widget with ProviderScope
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'FlickBuy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Riverpod Counter Example'),
    );
  }
}
