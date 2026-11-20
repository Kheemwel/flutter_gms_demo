// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Auth)
final authProvider = AuthProvider._();

final class AuthProvider extends $NotifierProvider<Auth, UserAccount?> {
  AuthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authHash();

  @$internal
  @override
  Auth create() => Auth();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAccount? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAccount?>(value),
    );
  }
}

String _$authHash() => r'e462d9c53024961111ad5299b35681523f031c4d';

abstract class _$Auth extends $Notifier<UserAccount?> {
  UserAccount? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UserAccount?, UserAccount?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserAccount?, UserAccount?>,
              UserAccount?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
