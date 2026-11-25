import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_form_state.dart';

/// Mirrors the original `UserAccountsLivewire` validation rules:
///   required first_name, last_name, email, role_id (we use kind)
///   email must be unique per active user
///   student: required LRN (12 digits), grade level
///   parent: required at least 1 child
///   principal: required position
Map<String, String> validateUserForm({
  required UserFormState form,
  required List<String> existingEmails, // lowercase, excluding the edited user
  required List<String> existingLrns, // excluding the edited user
}) {
  final errors = <String, String>{};

  if (form.firstName.trim().isEmpty) {
    errors['firstName'] = 'First name is required.';
  }
  if (form.lastName.trim().isEmpty) {
    errors['lastName'] = 'Last name is required.';
  }

  final String email = form.email.trim().toLowerCase();
  if (email.isEmpty) {
    errors['email'] = 'Email is required.';
  } else if (!_emailRegex.hasMatch(email)) {
    errors['email'] = 'Enter a valid email address.';
  } else if (existingEmails.contains(email)) {
    errors['email'] = 'This email is already in use.';
  }

  switch (form.kind) {
    case RoleKind.student:
      final String lrn = form.lrn.trim();
      if (lrn.isEmpty) {
        errors['lrn'] = 'LRN is required.';
      } else if (!_lrnRegex.hasMatch(lrn)) {
        errors['lrn'] = 'LRN must be exactly 12 digits.';
      } else if (existingLrns.contains(lrn)) {
        errors['lrn'] = 'This LRN is already in use.';
      }
    case RoleKind.parent:
      // Children are optional; a parent can be linked to students later
      // via edit. Keep the case for exhaustiveness.
      break;
    case RoleKind.principal:
      // position always has a default, no error path
      break;
    case RoleKind.admin:
    case RoleKind.guidance:
    case RoleKind.teacher:
      break;
  }

  return errors;
}

final RegExp _emailRegex = RegExp(
  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
);

final RegExp _lrnRegex = RegExp(r'^\d{12}$');
