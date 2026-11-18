// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(formsRepository)
final formsRepositoryProvider = FormsRepositoryProvider._();

final class FormsRepositoryProvider
    extends
        $FunctionalProvider<FormsRepository, FormsRepository, FormsRepository>
    with $Provider<FormsRepository> {
  FormsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FormsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FormsRepository create(Ref ref) {
    return formsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FormsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FormsRepository>(value),
    );
  }
}

String _$formsRepositoryHash() => r'34f7abf9c2a2a4de73ef5320f148aefed3df9616';

@ProviderFor(Forms)
final formsProvider = FormsProvider._();

final class FormsProvider extends $NotifierProvider<Forms, List<Form>> {
  FormsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'formsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$formsHash();

  @$internal
  @override
  Forms create() => Forms();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Form> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Form>>(value),
    );
  }
}

String _$formsHash() => r'6623d391187e75948270bff4b000fd7de7c6e6b1';

abstract class _$Forms extends $Notifier<List<Form>> {
  List<Form> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Form>, List<Form>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Form>, List<Form>>,
              List<Form>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
