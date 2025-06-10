import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Required for code generation
part 'sign_in_controller.g.dart';
part 'sign_in_controller.freezed.dart';

/// State for the sign-in screen.
@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SignInState;
  factory SignInState.fromJson(Map<String, dynamic> json) => _$SignInStateFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Controller for the sign-in screen.
@riverpod
class SignInController extends _$SignInController {
  @override
  SignInState build() {
    return SignInState();
  }

  void setEmail(String email) => state = state.copyWith(email: email);
  void setPassword(String password) => state = state.copyWith(password: password);

  Future<void> signIn() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    // TODO: Implement actual sign-in logic (e.g., API call with state.email and state.password)
    await Future.delayed(const Duration(seconds: 2)); // Simulate network request
    state = state.copyWith(isLoading: false);
    // TODO: Handle success or error based on the API response
    // For example: if (error) state = state.copyWith(errorMessage: "Invalid credentials");
    // else if (success) { /* navigate to home or dashboard */ }
  }
}