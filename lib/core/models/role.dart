import 'package:freezed_annotation/freezed_annotation.dart';

import 'privilege.dart';
import 'user_role.dart';

part 'role.freezed.dart';

@freezed
abstract class Role with _$Role {
  const factory Role({
    required String id,
    required String name,
    required RoleKind kind,
    required Set<Privilege> privileges,
  }) = _Role;
}
