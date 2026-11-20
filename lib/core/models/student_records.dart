import 'package:freezed_annotation/freezed_annotation.dart';

import 'grade_level.dart';

part 'student_records.freezed.dart';

@freezed
abstract class StudentIndividualInventory with _$StudentIndividualInventory {
  const factory StudentIndividualInventory({
    required String id,
    required String studentId,

    // Basic
    String? middleName,
    String? address,
    DateTime? birthday,
    String? religion,
    String? nationality,

    // Family
    String? fatherName,
    String? fatherContact,
    String? fatherOccupation,
    String? motherName,
    String? motherContact,
    String? motherOccupation,
    String? guardianName,
    String? guardianContact,
    String? guardianRelation,

    // Health
    String? healthConditions,
    String? allergies,
    String? medications,

    // Academic
    String? previousSchool,
    GradeLevel? previousGradeLevel,
    String? generalAverage,
  }) = _StudentIndividualInventory;
}

@freezed
abstract class StudentAnecdotal with _$StudentAnecdotal {
  const factory StudentAnecdotal({
    required String id,
    required String studentId,
    required String authorUserId,
    required String authorFullName,
    required DateTime observedAt,
    required String category,
    required String narrative,

    /// Base64 data URL of the author's signature.
    /// Placeholder in the port until the assets batch.
    String? authorSignatureDataUrl,

    /// Signature of the student acknowledging the entry.
    String? studentSignatureDataUrl,

    /// Signature of the parent, if the entry was routed to them.
    String? parentSignatureDataUrl,
  }) = _StudentAnecdotal;

  const StudentAnecdotal._();

  bool get authorSigned => authorSignatureDataUrl != null;
  bool get studentSigned => studentSignatureDataUrl != null;
  bool get parentSigned => parentSignatureDataUrl != null;
}
