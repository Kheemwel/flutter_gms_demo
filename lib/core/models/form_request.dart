import 'package:freezed_annotation/freezed_annotation.dart';

import 'form.dart';

part 'form_request.freezed.dart';

/// Status of a request as it moves through approval.
enum FormRequestStatus {
  pending,
  approved,
  disapproved;

  String get label => switch (this) {
    FormRequestStatus.pending => 'Pending',
    FormRequestStatus.approved => 'Approved',
    FormRequestStatus.disapproved => 'Disapproved',
  };
}

/// The teacher's ask. Separate sealed variant per requestable form type.
/// We deliberately do NOT store a `Form` here — the actual form is only
/// created when the request is approved, so the pre-approval state and
/// the post-approval state are clearly distinct.
@freezed
sealed class FormRequestPayload with _$FormRequestPayload {
  const factory FormRequestPayload.homeVisitation({
    required String teacherId,
    required String teacherName,
    required String studentId,
    required String studentName,
    required String reason,
  }) = HomeVisitationRequestPayload;

  const factory FormRequestPayload.violation({
    required String teacherId,
    required String teacherName,
    required List<String> studentIds,
    required List<String> studentNames,
    required String reason,
  }) = ViolationRequestPayload;
}

@freezed
abstract class FormRequest with _$FormRequest {
  const factory FormRequest({
    required String id,
    required FormRequestStatus status,
    required String requestedByUserId,
    required DateTime createdAt,
    required FormRequestPayload payload,

    /// When approved, the ID of the spawned [Form].
    String? resultingFormId,

    /// When disapproved, the reason given by guidance.
    String? disapprovalReason,
  }) = _FormRequest;

  const FormRequest._();

  FormType get formType => switch (payload) {
    HomeVisitationRequestPayload() => FormType.homeVisitation,
    ViolationRequestPayload() => FormType.violation,
  };

  /// Human-readable request ID: "REQ#17".
  String get displayId => 'REQ#$id';

  /// Who should be notified about this request.
  Set<String> get participantIds => switch (payload) {
    HomeVisitationRequestPayload p => {p.teacherId, p.studentId},
    ViolationRequestPayload p => {...p.studentIds, p.teacherId},
  };
}
