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
    r'40933c006c8f07f1bbbf1c7dc2382e01fbd866d1';

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
    r'd5f57921c84fe7ccc129499f5630b0bdf62b1bca';

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
