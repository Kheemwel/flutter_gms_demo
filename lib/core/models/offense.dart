import 'package:freezed_annotation/freezed_annotation.dart';

part 'offense.freezed.dart';

@freezed
abstract class OffenseCategory with _$OffenseCategory {
  const factory OffenseCategory({required String id, required String name}) =
      _OffenseCategory;
}

@freezed
abstract class OffenseLevel with _$OffenseLevel {
  const factory OffenseLevel({
    required String id,
    required String name,

    /// 1 = minor, 5 = severe. Used for sorting the offense list
    /// and for visual severity chips.
    required int severity,
  }) = _OffenseLevel;
}

@freezed
abstract class DisciplinaryAction with _$DisciplinaryAction {
  const factory DisciplinaryAction({
    required String id,
    required String name,
    @Default('') String description,
  }) = _DisciplinaryAction;
}

@freezed
abstract class Offense with _$Offense {
  const factory Offense({
    required String id,
    required String name,
    required String categoryId,
    required String levelId,

    /// Set of DisciplinaryAction ids that can be applied to this offense.
    @Default(<String>[]) List<String> actionIds,
    @Default('') String description,
  }) = _Offense;
}
