import 'package:flutter_gms_demo/core/models/form.dart';

List<Form> seedForms() {
  final now = DateTime.now();

  return [
    // Guidance created a Violation form for Sam; both Sam and the
    // teacher have fields to fill (teacher is prepopulated as author,
    // so from Sam's view there's fields to fill).
    Form(
      id: '1',
      formType: FormType.violation,
      status: FormStatus.incomplete,
      createdByUserId: 'user-2', // Grace Guidance
      createdAt: now.subtract(const Duration(days: 1)),
      data: const FormData.violation(
        teacherId: 'user-5', // Tina Teacher
        teacherName: 'Tina Teacher',
        studentIds: ['user-3'], // Sam
        studentNames: ['Sam Student'],
        guidanceId: 'user-2',
        guidanceName: 'Grace Guidance',
      ),
    ),
    // A home visitation form for Sam; the guidance step is partially
    // prefilled from Sam's profile but not yet completed.
    Form(
      id: '2',
      formType: FormType.homeVisitation,
      status: FormStatus.incomplete,
      createdByUserId: 'user-2',
      createdAt: now.subtract(const Duration(hours: 6)),
      data: const FormData.homeVisitation(
        studentId: 'user-3',
        studentName: 'Sam Student',
        teacherId: 'user-5',
        teacherName: 'Tina Teacher',
        guidanceId: 'user-2',
        guidanceName: 'Grace Guidance',
        parentId: 'user-4',
        parentName: 'Pat Parent',
        juniorPrincipalId: 'user-6',
        juniorPrincipalName: 'Junior Principal',
        seniorPrincipalId: 'user-7',
        seniorPrincipalName: 'Senior Principal',
        fields: {
          // Prefilled from Sam's profile
          'student_surname': 'Student',
          'student_firstname': 'Sam',
          'lrn': '123456789012',
          'level_section': 'Grade 9 Mars',
        },
      ),
    ),
  ];
}
