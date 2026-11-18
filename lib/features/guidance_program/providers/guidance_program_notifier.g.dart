// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidance_program_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(guidanceProgramRepository)
final guidanceProgramRepositoryProvider = GuidanceProgramRepositoryProvider._();

final class GuidanceProgramRepositoryProvider
    extends
        $FunctionalProvider<
          GuidanceProgramRepository,
          GuidanceProgramRepository,
          GuidanceProgramRepository
        >
    with $Provider<GuidanceProgramRepository> {
  GuidanceProgramRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guidanceProgramRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guidanceProgramRepositoryHash();

  @$internal
  @override
  $ProviderElement<GuidanceProgramRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GuidanceProgramRepository create(Ref ref) {
    return guidanceProgramRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuidanceProgramRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuidanceProgramRepository>(value),
    );
  }
}

String _$guidanceProgramRepositoryHash() =>
    r'd4c9294d87aea11bf81ca2d8d6fe7b6ddcb61f8e';

@ProviderFor(GuidancePrograms)
final guidanceProgramsProvider = GuidanceProgramsProvider._();

final class GuidanceProgramsProvider
    extends $NotifierProvider<GuidancePrograms, List<GuidanceProgram>> {
  GuidanceProgramsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guidanceProgramsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guidanceProgramsHash();

  @$internal
  @override
  GuidancePrograms create() => GuidancePrograms();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<GuidanceProgram> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<GuidanceProgram>>(value),
    );
  }
}

String _$guidanceProgramsHash() => r'b36f2ca1e38f56a9628fcedcd038f3adbbf5d1a4';

abstract class _$GuidancePrograms extends $Notifier<List<GuidanceProgram>> {
  List<GuidanceProgram> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<GuidanceProgram>, List<GuidanceProgram>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<GuidanceProgram>, List<GuidanceProgram>>,
              List<GuidanceProgram>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(GuidanceScheduleTags)
final guidanceScheduleTagsProvider = GuidanceScheduleTagsProvider._();

final class GuidanceScheduleTagsProvider
    extends $NotifierProvider<GuidanceScheduleTags, List<GuidanceScheduleTag>> {
  GuidanceScheduleTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guidanceScheduleTagsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guidanceScheduleTagsHash();

  @$internal
  @override
  GuidanceScheduleTags create() => GuidanceScheduleTags();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<GuidanceScheduleTag> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<GuidanceScheduleTag>>(value),
    );
  }
}

String _$guidanceScheduleTagsHash() =>
    r'ee2ad07c1e0c8645433cfa4440c1ebbf57c05a90';

abstract class _$GuidanceScheduleTags
    extends $Notifier<List<GuidanceScheduleTag>> {
  List<GuidanceScheduleTag> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<GuidanceScheduleTag>, List<GuidanceScheduleTag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<GuidanceScheduleTag>, List<GuidanceScheduleTag>>,
              List<GuidanceScheduleTag>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
