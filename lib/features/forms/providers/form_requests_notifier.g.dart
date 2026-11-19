// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_requests_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(formRequestsRepository)
final formRequestsRepositoryProvider = FormRequestsRepositoryProvider._();

final class FormRequestsRepositoryProvider
    extends
        $FunctionalProvider<
          FormRequestsRepository,
          FormRequestsRepository,
          FormRequestsRepository
        >
    with $Provider<FormRequestsRepository> {
  FormRequestsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formRequestsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formRequestsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FormRequestsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FormRequestsRepository create(Ref ref) {
    return formRequestsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FormRequestsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FormRequestsRepository>(value),
    );
  }
}

String _$formRequestsRepositoryHash() =>
    r'f292f1b835aa2e12ca43dc5ef0c7ea3ed3374ccc';

@ProviderFor(FormRequestsNotifier)
final formRequestsProvider = FormRequestsNotifierProvider._();

final class FormRequestsNotifierProvider
    extends $NotifierProvider<FormRequestsNotifier, List<FormRequest>> {
  FormRequestsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formRequestsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formRequestsNotifierHash();

  @$internal
  @override
  FormRequestsNotifier create() => FormRequestsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FormRequest> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FormRequest>>(value),
    );
  }
}

String _$formRequestsNotifierHash() =>
    r'e4a4d1916cebdb546fc5a580ed8badba4cab5c85';

abstract class _$FormRequestsNotifier extends $Notifier<List<FormRequest>> {
  List<FormRequest> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<FormRequest>, List<FormRequest>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FormRequest>, List<FormRequest>>,
              List<FormRequest>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
