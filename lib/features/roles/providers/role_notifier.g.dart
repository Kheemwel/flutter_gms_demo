// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RolesNotifier)
final rolesProvider = RolesNotifierProvider._();

final class RolesNotifierProvider
    extends $NotifierProvider<RolesNotifier, List<Role>> {
  RolesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rolesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rolesNotifierHash();

  @$internal
  @override
  RolesNotifier create() => RolesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Role> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Role>>(value),
    );
  }
}

String _$rolesNotifierHash() => r'f23cb0725bd9234f3b46509400464f4cfd46fba3';

abstract class _$RolesNotifier extends $Notifier<List<Role>> {
  List<Role> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Role>, List<Role>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Role>, List<Role>>,
              List<Role>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
