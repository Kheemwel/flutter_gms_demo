// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_content_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SiteContentNotifier)
final siteContentProvider = SiteContentNotifierProvider._();

final class SiteContentNotifierProvider
    extends $NotifierProvider<SiteContentNotifier, SiteContent> {
  SiteContentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'siteContentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$siteContentNotifierHash();

  @$internal
  @override
  SiteContentNotifier create() => SiteContentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SiteContent value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SiteContent>(value),
    );
  }
}

String _$siteContentNotifierHash() =>
    r'423dc94f2049cd928e0af283ea4baeccba755e1b';

abstract class _$SiteContentNotifier extends $Notifier<SiteContent> {
  SiteContent build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SiteContent, SiteContent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SiteContent, SiteContent>,
              SiteContent,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
