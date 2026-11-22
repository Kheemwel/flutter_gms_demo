// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_records_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(studentRecordsRepository)
final studentRecordsRepositoryProvider = StudentRecordsRepositoryProvider._();

final class StudentRecordsRepositoryProvider
    extends
        $FunctionalProvider<
          StudentRecordsRepository,
          StudentRecordsRepository,
          StudentRecordsRepository
        >
    with $Provider<StudentRecordsRepository> {
  StudentRecordsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentRecordsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentRecordsRepositoryHash();

  @$internal
  @override
  $ProviderElement<StudentRecordsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StudentRecordsRepository create(Ref ref) {
    return studentRecordsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StudentRecordsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StudentRecordsRepository>(value),
    );
  }
}

String _$studentRecordsRepositoryHash() =>
    r'd09e5d7f21ad67027fcdc1246a3bc5153416e826';

@ProviderFor(StudentInventoriesNotifier)
final studentInventoriesProvider = StudentInventoriesNotifierProvider._();

final class StudentInventoriesNotifierProvider
    extends
        $NotifierProvider<
          StudentInventoriesNotifier,
          List<StudentIndividualInventory>
        > {
  StudentInventoriesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentInventoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentInventoriesNotifierHash();

  @$internal
  @override
  StudentInventoriesNotifier create() => StudentInventoriesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StudentIndividualInventory> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StudentIndividualInventory>>(
        value,
      ),
    );
  }
}

String _$studentInventoriesNotifierHash() =>
    r'09d586605211b0da0c03f8fb9ca8e7aca6f2a2b1';

abstract class _$StudentInventoriesNotifier
    extends $Notifier<List<StudentIndividualInventory>> {
  List<StudentIndividualInventory> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              List<StudentIndividualInventory>,
              List<StudentIndividualInventory>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<StudentIndividualInventory>,
                List<StudentIndividualInventory>
              >,
              List<StudentIndividualInventory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(StudentAnecdotalsNotifier)
final studentAnecdotalsProvider = StudentAnecdotalsNotifierProvider._();

final class StudentAnecdotalsNotifierProvider
    extends
        $NotifierProvider<StudentAnecdotalsNotifier, List<StudentAnecdotal>> {
  StudentAnecdotalsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studentAnecdotalsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studentAnecdotalsNotifierHash();

  @$internal
  @override
  StudentAnecdotalsNotifier create() => StudentAnecdotalsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StudentAnecdotal> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StudentAnecdotal>>(value),
    );
  }
}

String _$studentAnecdotalsNotifierHash() =>
    r'4d7d3cacd1e13e03f80a1874ec6316201a7ee67a';

abstract class _$StudentAnecdotalsNotifier
    extends $Notifier<List<StudentAnecdotal>> {
  List<StudentAnecdotal> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<StudentAnecdotal>, List<StudentAnecdotal>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<StudentAnecdotal>, List<StudentAnecdotal>>,
              List<StudentAnecdotal>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
