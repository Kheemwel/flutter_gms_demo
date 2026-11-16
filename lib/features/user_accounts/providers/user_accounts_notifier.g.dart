// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_accounts_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userAccountsRepository)
final userAccountsRepositoryProvider = UserAccountsRepositoryProvider._();

final class UserAccountsRepositoryProvider
    extends
        $FunctionalProvider<
          UserAccountsRepository,
          UserAccountsRepository,
          UserAccountsRepository
        >
    with $Provider<UserAccountsRepository> {
  UserAccountsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAccountsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAccountsRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserAccountsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserAccountsRepository create(Ref ref) {
    return userAccountsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAccountsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAccountsRepository>(value),
    );
  }
}

String _$userAccountsRepositoryHash() =>
    r'bef68c2410595a905f2222640ca3d43bb358d57c';

@ProviderFor(UserAccounts)
final userAccountsProvider = UserAccountsProvider._();

final class UserAccountsProvider
    extends $NotifierProvider<UserAccounts, List<UserAccount>> {
  UserAccountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAccountsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAccountsHash();

  @$internal
  @override
  UserAccounts create() => UserAccounts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAccount> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAccount>>(value),
    );
  }
}

String _$userAccountsHash() => r'5311300a50ceca07b78e289dd7b13febe9cc8ad6';

abstract class _$UserAccounts extends $Notifier<List<UserAccount>> {
  List<UserAccount> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<UserAccount>, List<UserAccount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<UserAccount>, List<UserAccount>>,
              List<UserAccount>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
