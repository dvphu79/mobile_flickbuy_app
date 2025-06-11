import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  () {
    return AuthController();
  },
);

class AuthController extends AsyncNotifier<AppUser?> {
  bool _isInitialBuildComplete = false;
  bool get isInitialBuildComplete => _isInitialBuildComplete;

  @override
  Future<AppUser?> build() async {
    _isInitialBuildComplete = false;
    // Attempt to load the current user when the provider is initialized.
    // The AuthRepository's getCurrentUser() handles AppwriteExceptions for no session.
    try {
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      _isInitialBuildComplete = true;
      return user;
    } catch (e) {
      _isInitialBuildComplete = true;
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    try {
      await ref.read(authRepositoryProvider).signOut();
    } finally {
      state = const AsyncValue.data(null); // Ensure user state is cleared
    }
  }
}
