// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuditLogsNotifier)
final auditLogsProvider = AuditLogsNotifierProvider._();

final class AuditLogsNotifierProvider
    extends $NotifierProvider<AuditLogsNotifier, List<AuditLog>> {
  AuditLogsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'auditLogsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$auditLogsNotifierHash();

  @$internal
  @override
  AuditLogsNotifier create() => AuditLogsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AuditLog> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AuditLog>>(value),
    );
  }
}

String _$auditLogsNotifierHash() => r'3b86b35a9b34319af6a3715672fb6543fda9b85b';

abstract class _$AuditLogsNotifier extends $Notifier<List<AuditLog>> {
  List<AuditLog> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<AuditLog>, List<AuditLog>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AuditLog>, List<AuditLog>>,
              List<AuditLog>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
