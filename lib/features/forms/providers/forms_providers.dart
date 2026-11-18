import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_notifier.dart';
import 'package:hooks_riverpod/misc.dart';

/// The signer role that the current user represents on a given form.
SignerRole? _signerRoleFor({required String userId, required Form form}) {
  return switch (form.data) {
    HomeVisitationFormData d => switch (userId) {
      _ when d.studentId == userId => SignerRole.student,
      _ when d.parentId == userId => SignerRole.parent,
      _ when d.teacherId == userId => SignerRole.teacher,
      _ when d.guidanceId == userId => SignerRole.guidance,
      _ when d.juniorPrincipalId == userId => SignerRole.juniorPrincipal,
      _ when d.seniorPrincipalId == userId => SignerRole.seniorPrincipal,
      _ => null,
    },
    ViolationFormData d => switch (userId) {
      _ when d.studentIds.contains(userId) => SignerRole.student,
      _ when d.teacherId == userId => SignerRole.teacher,
      _ when d.guidanceId == userId => SignerRole.guidance,
      _ => null,
    },
  };
}

/// Forms the current user participates in, split by status.
/// This is the port of the original `loadForms()` role-based filters,
/// but expressed as data rather than a maze of `orWhereHas`.
final Provider<({List<Form> toFill, List<Form> completed})> myFormsProvider =
    Provider<({List<Form> toFill, List<Form> completed})>((ref) {
      final UserAccount? me = ref.watch(authProvider);
      final List<Form> all = ref.watch(formsProvider);
      if (me == null) {
        return (toFill: const <Form>[], completed: const <Form>[]);
      }

      // Guidance sees everything they created or participate in.
      // Other roles see only their own.
      final String roleKind = switch (me.profile) {
        StudentProfile() => 'student',
        ParentProfile() => 'parent',
        TeacherProfile() => 'teacher',
        PrincipalProfile() => 'principal',
        GuidanceProfile() => 'guidance',
        AdminProfile() => 'admin',
      };

      bool isMine(Form f) {
        if (roleKind == 'admin' || roleKind == 'guidance') {
          return f.data is HomeVisitationFormData
              ? (f.data as HomeVisitationFormData).guidanceId == me.id ||
                    f.createdByUserId == me.id
              : (f.data as ViolationFormData).guidanceId == me.id ||
                    f.createdByUserId == me.id;
        }
        return f.participants.contains(me.id);
      }

      final List<Form> mine = all.where(isMine).toList(growable: false);
      final List<Form> toFill =
          mine
              .where((f) => f.status == FormStatus.incomplete)
              .toList(growable: false)
            ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      final List<Form> completed =
          mine
              .where((f) => f.status == FormStatus.complete)
              .toList(growable: false)
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return (toFill: toFill, completed: completed);
    });

/// The role the current user is playing on a given form.
/// Null if they aren't a participant.
final ProviderFamily<SignerRole?, Form> mySignerRoleForFormProvider =
    Provider.family<SignerRole?, Form>((ref, form) {
      final UserAccount? me = ref.watch(authProvider);
      if (me == null) return null;
      return _signerRoleFor(userId: me.id, form: form);
    });
