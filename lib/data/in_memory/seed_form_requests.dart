import 'package:flutter_gms_demo/core/models/form_request.dart';

List<FormRequest> seedFormRequests() {
  final now = DateTime.now();

  return [
    FormRequest(
      id: '1',
      status: FormRequestStatus.pending,
      requestedByUserId: 'user-5', // Tina Teacher
      createdAt: now.subtract(const Duration(hours: 3)),
      payload: const FormRequestPayload.homeVisitation(
        teacherId: 'user-5',
        teacherName: 'Tina Teacher',
        studentId: 'user-3',
        studentName: 'Sam Student',
        reason:
            'Sam has missed 4 days of class in the last two weeks. '
            'A home visit would help us understand what is going on '
            'at home.',
      ),
    ),
    FormRequest(
      id: '2',
      status: FormRequestStatus.pending,
      requestedByUserId: 'user-5',
      createdAt: now.subtract(const Duration(minutes: 45)),
      payload: const FormRequestPayload.violation(
        teacherId: 'user-5',
        teacherName: 'Tina Teacher',
        studentIds: ['user-3'],
        studentNames: ['Sam Student'],
        reason:
            'Repeated disruption in class. Need a formal violation '
            'form started so the guidance office can follow up.',
      ),
    ),
  ];
}
