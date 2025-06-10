// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignInState _$SignInStateFromJson(Map<String, dynamic> json) => _SignInState(
  email: json['email'] as String? ?? '',
  password: json['password'] as String? ?? '',
  isLoading: json['isLoading'] as bool? ?? false,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$SignInStateToJson(_SignInState instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'isLoading': instance.isLoading,
      'errorMessage': instance.errorMessage,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInControllerHash() => r'5cf831adba39442a272e6173cb93aae4bcdbd892';

/// Controller for the sign-in screen.
///
/// Copied from [SignInController].
@ProviderFor(SignInController)
final signInControllerProvider =
    AutoDisposeNotifierProvider<SignInController, SignInState>.internal(
      SignInController.new,
      name: r'signInControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$signInControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SignInController = AutoDisposeNotifier<SignInState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
