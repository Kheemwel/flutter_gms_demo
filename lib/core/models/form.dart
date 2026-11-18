import 'package:freezed_annotation/freezed_annotation.dart';

part 'form.freezed.dart';

/// Form lifecycle. Replaces the string `status` + separate `is_approve`
/// flag from the original (which could disagree).
enum FormStatus { incomplete, complete }

/// Which party is responsible for a given signature.
enum SignerRole {
  student,
  parent,
  teacher,
  guidance,
  juniorPrincipal,
  seniorPrincipal;

  String get label => switch (this) {
    SignerRole.student => 'Student',
    SignerRole.parent => 'Parent',
    SignerRole.teacher => 'Teacher',
    SignerRole.guidance => 'Guidance',
    SignerRole.juniorPrincipal => 'Junior Principal',
    SignerRole.seniorPrincipal => 'Senior Principal',
  };
}

/// Discriminator used by the forms list and filters.
enum FormType {
  homeVisitation,
  violation;

  String get label => switch (this) {
    FormType.homeVisitation => 'Home Visitation Form',
    FormType.violation => 'Violation Form',
  };

  String get shortCode => switch (this) {
    FormType.homeVisitation => 'HF',
    FormType.violation => 'VF',
  };
}

/// A required-or-optional field on a form. The form data is stored as
/// a `Map<String, String>` keyed by [key]; this list is the schema.
class FormFieldSpec {
  const FormFieldSpec({
    required this.key,
    required this.label,
    this.required = false,
    this.multiline = false,
  });

  final String key;
  final String label;
  final bool required;
  final bool multiline;
}

/// Base for the two form-data variants.
@freezed
sealed class FormData with _$FormData {
  const factory FormData.homeVisitation({
    required String studentId,
    required String studentName,
    required String teacherId,
    required String teacherName,
    required String guidanceId,
    required String guidanceName,
    required String parentId,
    required String parentName,
    required String juniorPrincipalId,
    required String juniorPrincipalName,
    required String seniorPrincipalId,
    required String seniorPrincipalName,
    @Default(<String, String>{}) Map<String, String> fields,
    @Default(<SignerRole, String>{}) Map<SignerRole, String> signatures,
  }) = HomeVisitationFormData;

  const factory FormData.violation({
    required String teacherId,
    required String teacherName,
    required List<String> studentIds,
    required List<String> studentNames,
    required String guidanceId,
    required String guidanceName,
    @Default(<String, String>{}) Map<String, String> fields,
    @Default(<SignerRole, String>{}) Map<SignerRole, String> signatures,
  }) = ViolationFormData;
}

@freezed
abstract class Form with _$Form {
  const factory Form({
    required String id,
    required FormType formType,
    required FormStatus status,
    required String createdByUserId,
    required DateTime createdAt,
    required FormData data,
  }) = _Form;

  const Form._();

  /// Human-readable ID: e.g. "HF#17" or "VF#42".
  String get displayId => '${formType.shortCode}#$id';

  /// The set of user IDs who need to do something with this form.
  /// Used by the forms list to decide "is this mine?".
  Set<String> get participants {
    return switch (data) {
      HomeVisitationFormData d => {
        d.studentId,
        d.parentId,
        d.teacherId,
        d.guidanceId,
        d.juniorPrincipalId,
        d.seniorPrincipalId,
      },
      ViolationFormData d => {...d.studentIds, d.teacherId, d.guidanceId},
    };
  }

  /// Required fields for this form type, in display order.
  /// Used for the "which fields are required" completion check.
  static List<FormFieldSpec> fieldsFor(FormType type) {
    return switch (type) {
      FormType.homeVisitation => homeVisitationFields,
      FormType.violation => violationFields,
    };
  }

  /// The fields the given signer role is responsible for filling.
  /// `null` means "this role has no fields to fill on this type".
  static Set<String>? editableFieldKeysFor(FormType type, SignerRole signer) {
    if (type == FormType.homeVisitation) {
      return switch (signer) {
        SignerRole.guidance => const {
          'visitation_date',
          'place',
          'reason',
          'remark',
        },
        SignerRole.teacher => const {'adviser'},
        _ => const <String>{},
      };
    }
    // Violation
    return switch (signer) {
      SignerRole.guidance => const {
        'date',
        'time',
        'offense_type',
        'narrative',
        'action_taken',
        'case_status',
        'recommendation',
      },
      _ => const <String>{},
    };
  }

  /// The signer roles that must sign this form type before it can
  /// auto-complete.
  static Set<SignerRole> requiredSignersFor(FormType type) {
    return switch (type) {
      FormType.homeVisitation => const {
        SignerRole.student,
        SignerRole.parent,
        SignerRole.teacher,
        SignerRole.guidance,
        SignerRole.juniorPrincipal,
        SignerRole.seniorPrincipal,
      },
      FormType.violation => const {
        SignerRole.student,
        SignerRole.teacher,
        SignerRole.guidance,
      },
    };
  }
}

// Field schemas — the "which fields are required" data.

const List<FormFieldSpec> homeVisitationFields = [
  // Prefilled from student profile; not required to edit but stored.
  FormFieldSpec(key: 'student_surname', label: 'Student surname'),
  FormFieldSpec(key: 'student_firstname', label: 'Student first name'),
  FormFieldSpec(key: 'student_middlename', label: 'Student middle name'),
  FormFieldSpec(key: 'student_no', label: 'Student number'),
  FormFieldSpec(key: 'lrn', label: 'LRN'),
  FormFieldSpec(key: 'level_section', label: 'Level & section'),
  FormFieldSpec(key: 'address', label: 'Address'),
  FormFieldSpec(key: 'birthday', label: 'Birthday'),
  FormFieldSpec(key: 'age', label: 'Age'),
  FormFieldSpec(key: 'father_name', label: "Father's name"),
  FormFieldSpec(key: 'father_contact', label: "Father's contact"),
  FormFieldSpec(key: 'mother_name', label: "Mother's name"),
  FormFieldSpec(key: 'mother_contact', label: "Mother's contact"),
  FormFieldSpec(key: 'guardian_name', label: "Guardian's name"),
  FormFieldSpec(key: 'guardian_contact', label: "Guardian's contact"),
  // Required fields for the guidance filling step:
  FormFieldSpec(
    key: 'visitation_date',
    label: 'Visitation date',
    required: true,
  ),
  FormFieldSpec(key: 'place', label: 'Place', required: true),
  FormFieldSpec(
    key: 'reason',
    label: 'Reason',
    required: true,
    multiline: true,
  ),
  FormFieldSpec(
    key: 'remark',
    label: 'Remark',
    required: true,
    multiline: true,
  ),
  FormFieldSpec(key: 'adviser', label: 'Adviser'),
];

const List<FormFieldSpec> violationFields = [
  FormFieldSpec(key: 'date', label: 'Date of incident', required: true),
  FormFieldSpec(key: 'time', label: 'Time of incident', required: true),
  FormFieldSpec(key: 'offense_type', label: 'Offense type', required: true),
  FormFieldSpec(
    key: 'narrative',
    label: 'Narrative',
    required: true,
    multiline: true,
  ),
  FormFieldSpec(
    key: 'action_taken',
    label: 'Action taken',
    required: true,
    multiline: true,
  ),
  FormFieldSpec(key: 'case_status', label: 'Case status', required: true),
  FormFieldSpec(
    key: 'recommendation',
    label: 'Recommendation',
    required: true,
    multiline: true,
  ),
];
