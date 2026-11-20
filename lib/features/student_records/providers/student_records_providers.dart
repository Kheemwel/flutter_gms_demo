import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';
import 'package:hooks_riverpod/legacy.dart';

/// All students (non-archived), sorted by name.
final Provider<List<UserAccount>> allStudentsProvider =
    Provider<List<UserAccount>>((ref) {
      final List<UserAccount> all = ref.watch(userAccountsProvider);
      return all
          .where((u) => u.profile is StudentProfile && !u.isArchived)
          .toList(growable: false)
        ..sort((a, b) => a.fullName.compareTo(b.fullName));
    });

/// Search string for the students table.
final StateProvider<String> studentSearchProvider = StateProvider<String>(
  (ref) => '',
);

/// Optional grade-level filter.
final StateProvider<GradeLevel?> studentGradeFilterProvider =
    StateProvider<GradeLevel?>((ref) => null);

final Provider<List<UserAccount>> filteredStudentsProvider =
    Provider<List<UserAccount>>((ref) {
      final List<UserAccount> all = ref.watch(allStudentsProvider);
      final String q = ref.watch(studentSearchProvider).trim().toLowerCase();
      final GradeLevel? grade = ref.watch(studentGradeFilterProvider);

      return all
          .where((s) {
            if (grade != null) {
              final UserProfile p = s.profile;
              if (p is StudentProfile && p.gradeLevel != grade) return false;
            }
            if (q.isEmpty) return true;
            return s.fullName.toLowerCase().contains(q) ||
                s.email.toLowerCase().contains(q) ||
                (s.profile is StudentProfile &&
                    (s.profile as StudentProfile).lrn.contains(q));
          })
          .toList(growable: false);
    });

/// The signed-in student's inventory, if they are a student.
final Provider<StudentIndividualInventory?> myInventoryProvider =
    Provider<StudentIndividualInventory?>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      if (me == null || me.profile is! StudentProfile) return null;
      return ref.watch(studentInventoriesProvider.notifier).forStudent(me.id);
    });

/// The signed-in student's anecdotal entries.
final Provider<List<StudentAnecdotal>> myAnecdotalsProvider =
    Provider<List<StudentAnecdotal>>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      if (me == null || me.profile is! StudentProfile) return const [];
      return ref.watch(studentAnecdotalsProvider.notifier).forStudent(me.id);
    });

/// Child user accounts for the signed-in parent.
final Provider<List<UserAccount>> myChildrenProvider =
    Provider<List<UserAccount>>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      if (me == null || me.profile is! ParentProfile) return const [];
      final List<String> childIds = (me.profile as ParentProfile).childIds;
      final List<UserAccount> all = ref.watch(userAccountsProvider);
      return all
          .where((u) => childIds.contains(u.id) && !u.isArchived)
          .toList(growable: false);
    });

/// Selected child in the parent view (defaults to first child).
final StateProvider<String?> selectedChildIdProvider = StateProvider<String?>((
  ref,
) {
  final UserAccount? me = ref.watch(authProvider);
  if (me == null || me.profile is! ParentProfile) return null;
  final List<String> ids = (me.profile as ParentProfile).childIds;
  return ids.isEmpty ? null : ids.first;
});
