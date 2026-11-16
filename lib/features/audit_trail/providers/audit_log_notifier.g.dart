// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuditLogs)
final auditLogsProvider = AuditLogsProvider._();

final class AuditLogsProvider
    extends $NotifierProvider<AuditLogs, List<AuditLog>> {
  AuditLogsProvider._()
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
  String debugGetCreateSourceHash() => _$auditLogsHash();

  @$internal
  @override
  AuditLogs create() => AuditLogs();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AuditLog> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AuditLog>>(value),
    );
  }
}

String _$auditLogsHash() => r'a4f52ca0917d34896450bcd3f2704b956f3d19a2';

abstract class _$AuditLogs extends $Notifier<List<AuditLog>> {
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
