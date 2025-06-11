import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as appwrite_models;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/appwrite_provider.dart';
import '../domain/app_user.dart';

class AuthRepository {
  final Account _account;

  AuthRepository(this._account);

  Future<AppUser?> getCurrentUser() async {
    try {
      final appwrite_models.User user = await _account.get();
      return AppUser(uid: user.$id, email: user.email);
    } on AppwriteException catch (e) {
      if (e.code == 401 ||
          e.type == 'user_session_not_found' ||
          e.type == 'user_not_found') {
        // Common codes for no active session or user
        return null;
      }
      rethrow; // Rethrow other Appwrite exceptions
    }
  }

  Future<AppUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await _account.createEmailPasswordSession(email: email, password: password);
    final appwrite_models.User user = await _account.get();
    return AppUser(uid: user.$id, email: user.email);
  }

  Future<void> signOut() async {
    await _account.deleteSession(sessionId: 'current');
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthRepository(account);
});
