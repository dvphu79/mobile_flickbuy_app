// sign_in_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/features/auth/controllers/sign_in_controller.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInState = ref.watch(signInControllerProvider);
    final signInController = ref.read(signInControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0), // Adjusted padding for a bit more space
        child: Center( // Center the content
          child: ConstrainedBox( // Constrain the width for larger screens
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch, // Make button stretch
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your FlickBuy account',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  onChanged: signInController.setEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                  onChanged: signInController.setPassword,
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                if (signInState.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  FilledButton( // Using FilledButton for M3 primary action
                    onPressed: signInState.email.isNotEmpty && signInState.password.isNotEmpty
                        ? signInController.signIn
                        : null,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Sign In'),
                  ),
                if (signInState.errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    signInState.errorMessage!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Example of how to navigate to this screen (e.g., from your main.dart or a home page):
// Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const SignInScreen()),
// );

// Make sure your controller path is correct in the import statement.
// import 'package:mobile_flickbuy_app/src/features/auth/controllers/sign_in_controller.dart';
