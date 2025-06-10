import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/main.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. Watch the provider to get its current state
    // and to rebuild the widget when the state changes.
    final count = ref.watch(counterProvider);

    // 4. Read the provider's notifier to access methods
    // that can change the state (e.g., increment).
    final counterNotifier = ref.read(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times (Riverpod):',
            ),
            Text(
              '$count', // Display the counter's current value
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counterNotifier.state++, // Increment the counter
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
