// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offenses_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(offensesRepository)
final offensesRepositoryProvider = OffensesRepositoryProvider._();

final class OffensesRepositoryProvider
    extends
        $FunctionalProvider<
          OffensesRepository,
          OffensesRepository,
          OffensesRepository
        >
    with $Provider<OffensesRepository> {
  OffensesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offensesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offensesRepositoryHash();

  @$internal
  @override
  $ProviderElement<OffensesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OffensesRepository create(Ref ref) {
    return offensesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OffensesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OffensesRepository>(value),
    );
  }
}

String _$offensesRepositoryHash() =>
    r'9eae0537d0b5395ea15a4fe1044d565bbf61b645';

@ProviderFor(Offenses)
final offensesProvider = OffensesProvider._();

final class OffensesProvider
    extends $NotifierProvider<Offenses, List<Offense>> {
  OffensesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offensesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offensesHash();

  @$internal
  @override
  Offenses create() => Offenses();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Offense> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Offense>>(value),
    );
  }
}

String _$offensesHash() => r'08ab3b83dc998848f2142620f8f37cb477ac8dc6';

abstract class _$Offenses extends $Notifier<List<Offense>> {
  List<Offense> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Offense>, List<Offense>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Offense>, List<Offense>>,
              List<Offense>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(OffenseCategories)
final offenseCategoriesProvider = OffenseCategoriesProvider._();

final class OffenseCategoriesProvider
    extends $NotifierProvider<OffenseCategories, List<OffenseCategory>> {
  OffenseCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offenseCategoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offenseCategoriesHash();

  @$internal
  @override
  OffenseCategories create() => OffenseCategories();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OffenseCategory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OffenseCategory>>(value),
    );
  }
}

String _$offenseCategoriesHash() => r'56418a32b1e22296d1a0fd3252ace39b4053b975';

abstract class _$OffenseCategories extends $Notifier<List<OffenseCategory>> {
  List<OffenseCategory> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<OffenseCategory>, List<OffenseCategory>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<OffenseCategory>, List<OffenseCategory>>,
              List<OffenseCategory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(OffenseLevels)
final offenseLevelsProvider = OffenseLevelsProvider._();

final class OffenseLevelsProvider
    extends $NotifierProvider<OffenseLevels, List<OffenseLevel>> {
  OffenseLevelsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offenseLevelsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offenseLevelsHash();

  @$internal
  @override
  OffenseLevels create() => OffenseLevels();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<OffenseLevel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<OffenseLevel>>(value),
    );
  }
}

String _$offenseLevelsHash() => r'cd80402625ffbd838904126fecb9d46cb0dee417';

abstract class _$OffenseLevels extends $Notifier<List<OffenseLevel>> {
  List<OffenseLevel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<OffenseLevel>, List<OffenseLevel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<OffenseLevel>, List<OffenseLevel>>,
              List<OffenseLevel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(DisciplinaryActions)
final disciplinaryActionsProvider = DisciplinaryActionsProvider._();

final class DisciplinaryActionsProvider
    extends $NotifierProvider<DisciplinaryActions, List<DisciplinaryAction>> {
  DisciplinaryActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'disciplinaryActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$disciplinaryActionsHash();

  @$internal
  @override
  DisciplinaryActions create() => DisciplinaryActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<DisciplinaryAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<DisciplinaryAction>>(value),
    );
  }
}

String _$disciplinaryActionsHash() =>
    r'cdea3786a4d393a25bb4a8aadcf9f7e8a7e47bc1';

abstract class _$DisciplinaryActions
    extends $Notifier<List<DisciplinaryAction>> {
  List<DisciplinaryAction> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<DisciplinaryAction>, List<DisciplinaryAction>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<DisciplinaryAction>, List<DisciplinaryAction>>,
              List<DisciplinaryAction>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
