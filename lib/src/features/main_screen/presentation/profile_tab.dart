import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../auth/domain/app_user.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: authState.when(
          data: (AppUser? user) {
            if (user == null) {
              // This should ideally be prevented by router redirects
              return const Text('Not signed in. Redirecting...');
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User ID: ${user.uid}'),
                Text('Email: ${user.email ?? 'N/A'}'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed:
                      () => ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('Sign Out'),
                ),
              ],
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text('Error: $error'),
        ),
      ),
    );
  }
}
