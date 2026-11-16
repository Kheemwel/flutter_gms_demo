// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lost_and_found_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lostAndFoundRepository)
final lostAndFoundRepositoryProvider = LostAndFoundRepositoryProvider._();

final class LostAndFoundRepositoryProvider
    extends
        $FunctionalProvider<
          LostAndFoundRepository,
          LostAndFoundRepository,
          LostAndFoundRepository
        >
    with $Provider<LostAndFoundRepository> {
  LostAndFoundRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostAndFoundRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostAndFoundRepositoryHash();

  @$internal
  @override
  $ProviderElement<LostAndFoundRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LostAndFoundRepository create(Ref ref) {
    return lostAndFoundRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LostAndFoundRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LostAndFoundRepository>(value),
    );
  }
}

String _$lostAndFoundRepositoryHash() =>
    r'666cc39c578d8f388137bf771769c6f83612c738';

@ProviderFor(LostAndFoundItems)
final lostAndFoundItemsProvider = LostAndFoundItemsProvider._();

final class LostAndFoundItemsProvider
    extends $NotifierProvider<LostAndFoundItems, List<LostAndFoundItem>> {
  LostAndFoundItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostAndFoundItemsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostAndFoundItemsHash();

  @$internal
  @override
  LostAndFoundItems create() => LostAndFoundItems();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LostAndFoundItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LostAndFoundItem>>(value),
    );
  }
}

String _$lostAndFoundItemsHash() => r'160599b43e98e1da894cd9c0d52915b0f77bd0e7';

abstract class _$LostAndFoundItems extends $Notifier<List<LostAndFoundItem>> {
  List<LostAndFoundItem> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<LostAndFoundItem>, List<LostAndFoundItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<LostAndFoundItem>, List<LostAndFoundItem>>,
              List<LostAndFoundItem>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ItemTypes)
final itemTypesProvider = ItemTypesProvider._();

final class ItemTypesProvider
    extends $NotifierProvider<ItemTypes, List<ItemType>> {
  ItemTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemTypesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemTypesHash();

  @$internal
  @override
  ItemTypes create() => ItemTypes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ItemType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ItemType>>(value),
    );
  }
}

String _$itemTypesHash() => r'f2831afc436d556de85fcc00951b4c7d0c756dc5';

abstract class _$ItemTypes extends $Notifier<List<ItemType>> {
  List<ItemType> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<ItemType>, List<ItemType>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ItemType>, List<ItemType>>,
              List<ItemType>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ItemTags)
final itemTagsProvider = ItemTagsProvider._();

final class ItemTagsProvider
    extends $NotifierProvider<ItemTags, List<ItemTag>> {
  ItemTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemTagsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemTagsHash();

  @$internal
  @override
  ItemTags create() => ItemTags();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ItemTag> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ItemTag>>(value),
    );
  }
}

String _$itemTagsHash() => r'5824deb63663676e34eeb11004d906eee6eadd31';

abstract class _$ItemTags extends $Notifier<List<ItemTag>> {
  List<ItemTag> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<ItemTag>, List<ItemTag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ItemTag>, List<ItemTag>>,
              List<ItemTag>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
