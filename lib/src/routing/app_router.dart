import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flickbuy_app/src/features/products/presentation/product_detail_screen.dart';

import '../features/auth/controllers/auth_controller.dart';
import '../features/auth/domain/app_user.dart'; // Ensure AppUser is imported
import '../features/auth/presentation/sign_in_screen.dart';
import '../features/main_screen/presentation/main_screen.dart';

// Helper class to make Riverpod provider state a Listenable for GoRouter's refreshListenable
class AuthStateListenable extends ChangeNotifier {
  final Ref _ref;
  late final ProviderSubscription<AsyncValue<AppUser?>> _subscription;

  AuthStateListenable(this._ref) {
    _subscription = _ref.listen<AsyncValue<AppUser?>>(
      authControllerProvider,
      (previous, next) {
        notifyListeners();
      },
      fireImmediately: true, // Fire immediately to catch initial state
    );
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}

enum AppRoute { product }

final goRouterProvider = Provider<GoRouter>((ref) {
  final authListenable = AuthStateListenable(ref);

  return GoRouter(
    initialLocation: '/loading', // Start at a dedicated loading screen
    debugLogDiagnostics: true,
    refreshListenable: authListenable,
    redirect: (BuildContext context, GoRouterState state) {
      final authNotifier = ref.read(authControllerProvider.notifier);
      final authValue = ref.read(authControllerProvider);
      final isLoggedIn = authValue.valueOrNull != null;

      final String currentRoutePath = state.matchedLocation;

      // If initial authentication check (AuthController.build) is not yet complete
      if (!authNotifier.isInitialBuildComplete) {
        // Stay on the loading screen until the initial check is done.
        // If somehow not on /loading, redirect there.
        return currentRoutePath == '/loading' ? null : '/loading';
      }

      // Initial auth check is complete.
      // If we are on the loading screen, it's time to redirect.
      if (currentRoutePath == '/loading') {
        return isLoggedIn ? '/' : '/signIn';
      }

      // Standard route protection for other routes
      final bool onSignInScreen = currentRoutePath == '/signIn';

      // If not logged in and not already on the sign-in screen, redirect to sign-in.
      if (!isLoggedIn && !onSignInScreen) {
        return '/signIn';
      }

      // If logged in and on the sign-in screen, redirect to the main/home page.
      if (isLoggedIn && onSignInScreen) {
        return '/';
      }

      // No redirect needed in other cases.
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/loading',
        builder:
            (BuildContext context, GoRouterState state) => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
      ),
      GoRoute(
        path: '/',
        builder:
            (BuildContext context, GoRouterState state) => const MainScreen(),
      ),
      GoRoute(
        path: '/signIn',
        builder:
            (BuildContext context, GoRouterState state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        name: AppRoute.product.name,
        builder:
            (context, state) =>
                ProductDetailScreen(productId: state.pathParameters['id']!),
      ),
    ],
  );
});
