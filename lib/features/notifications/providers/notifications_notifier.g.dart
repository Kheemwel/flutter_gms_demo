// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppNotifications)
final appNotificationsProvider = AppNotificationsProvider._();

final class AppNotificationsProvider
    extends $NotifierProvider<AppNotifications, List<AppNotification>> {
  AppNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNotificationsHash();

  @$internal
  @override
  AppNotifications create() => AppNotifications();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppNotification> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppNotification>>(value),
    );
  }
}

String _$appNotificationsHash() => r'9c3a32c8c5c558591eab9dc9af21a7dd655c48d0';

abstract class _$AppNotifications extends $Notifier<List<AppNotification>> {
  List<AppNotification> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<AppNotification>, List<AppNotification>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AppNotification>, List<AppNotification>>,
              List<AppNotification>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
