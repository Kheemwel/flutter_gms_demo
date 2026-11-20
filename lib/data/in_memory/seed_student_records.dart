import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';

List<StudentIndividualInventory> seedStudentInventories() {
  return [
    StudentIndividualInventory(
      id: 'inv-1',
      studentId: 'user-3',
      middleName: 'A.',
      address: '123 Mabini St., Brgy. Poblacion, Quezon City',
      birthday: DateTime(2009, 5, 14),
      religion: 'Roman Catholic',
      nationality: 'Filipino',
      fatherName: 'Pat Parent',
      fatherContact: '09171234567',
      fatherOccupation: 'Driver',
      motherName: 'Maria Parent',
      motherContact: '09181234567',
      motherOccupation: 'Teacher',
      guardianName: 'Pat Parent',
      guardianContact: '09171234567',
      guardianRelation: 'Father',
      healthConditions: 'Mild asthma',
      allergies: 'Peanuts',
      medications: 'Salbutamol inhaler as needed',
      previousSchool: 'Rizal Elementary School',
      previousGradeLevel: GradeLevel.grade8,
      generalAverage: '88.5',
    ),
    StudentIndividualInventory(
      id: 'inv-2',
      studentId: 'user-3b',
      middleName: 'B.',
      address: '123 Mabini St., Brgy. Poblacion, Quezon City',
      birthday: DateTime(2008, 11, 2),
      religion: 'Roman Catholic',
      nationality: 'Filipino',
      fatherName: 'Pat Parent',
      fatherContact: '09171234567',
      fatherOccupation: 'Driver',
      motherName: 'Maria Parent',
      motherContact: '09181234567',
      motherOccupation: 'Teacher',
      guardianName: 'Pat Parent',
      guardianContact: '09171234567',
      guardianRelation: 'Father',
      previousSchool: 'Rizal Elementary School',
      previousGradeLevel: GradeLevel.grade9,
      generalAverage: '90.2',
    ),
  ];
}

List<StudentAnecdotal> seedStudentAnecdotals() {
  final now = DateTime.now();
  return [
    StudentAnecdotal(
      id: 'anec-1',
      studentId: 'user-3',
      authorUserId: 'user-2',
      authorFullName: 'Grace Guidance',
      observedAt: now.subtract(const Duration(days: 20)),
      category: 'Behavior',
      narrative:
          'Sam arrived noticeably tired three days in a row. '
          'Followed up during break — mentioned some disruption at home. '
          'Recommended a home visitation.',
    ),
    StudentAnecdotal(
      id: 'anec-2',
      studentId: 'user-3',
      authorUserId: 'user-5',
      authorFullName: 'Tina Teacher',
      observedAt: now.subtract(const Duration(days: 12)),
      category: 'Academic',
      narrative:
          'Sam has been disengaged in class since mid-quarter. '
          'Completed homework dropped from 90% to 60%. '
          'Spoke to Sam briefly; will escalate if it continues.',
    ),
    StudentAnecdotal(
      id: 'anec-3',
      studentId: 'user-3b',
      authorUserId: 'user-2',
      authorFullName: 'Grace Guidance',
      observedAt: now.subtract(const Duration(days: 5)),
      category: 'Achievement',
      narrative:
          'Alex placed 2nd in the interschool math olympiad. '
          'Shared the result with the principal for recognition.',
    ),
  ];
}
