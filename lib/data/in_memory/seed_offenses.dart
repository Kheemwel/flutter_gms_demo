import 'package:flutter_gms_demo/core/models/offense.dart';

final List<OffenseCategory> seedOffenseCategories = const [
  OffenseCategory(id: 'cat-attendance', name: 'Attendance'),
  OffenseCategory(id: 'cat-conduct', name: 'Conduct'),
  OffenseCategory(id: 'cat-uniform', name: 'Uniform & Grooming'),
  OffenseCategory(id: 'cat-property', name: 'Property'),
  OffenseCategory(id: 'cat-violence', name: 'Violence & Bullying'),
];

final List<OffenseLevel> seedOffenseLevels = const [
  OffenseLevel(id: 'lvl-minor', name: 'Minor', severity: 1),
  OffenseLevel(id: 'lvl-moderate', name: 'Moderate', severity: 2),
  OffenseLevel(id: 'lvl-serious', name: 'Serious', severity: 3),
  OffenseLevel(id: 'lvl-severe', name: 'Severe', severity: 4),
  OffenseLevel(id: 'lvl-critical', name: 'Critical', severity: 5),
];

final List<DisciplinaryAction> seedDisciplinaryActions = const [
  DisciplinaryAction(
    id: 'act-verbal-warning',
    name: 'Verbal warning',
    description: 'A documented conversation with the student.',
  ),
  DisciplinaryAction(
    id: 'act-written-warning',
    name: 'Written warning',
    description: 'A formal letter added to the student file.',
  ),
  DisciplinaryAction(
    id: 'act-parent-conference',
    name: 'Parent conference',
    description: 'Meeting with the student, parent, and guidance.',
  ),
  DisciplinaryAction(
    id: 'act-detention',
    name: 'Detention',
    description: 'After-school detention, 1–3 days.',
  ),
  DisciplinaryAction(
    id: 'act-suspension',
    name: 'Suspension',
    description: 'Out-of-school suspension, 1–5 days.',
  ),
  DisciplinaryAction(
    id: 'act-expulsion',
    name: 'Expulsion',
    description: 'Permanent removal. Requires principal approval.',
  ),
];

final List<Offense> seedOffenses = const [
  Offense(
    id: 'offense-late',
    name: 'Tardiness',
    categoryId: 'cat-attendance',
    levelId: 'lvl-minor',
    actionIds: ['act-verbal-warning', 'act-written-warning'],
    description: 'Arriving after the bell without a valid reason.',
  ),
  Offense(
    id: 'offense-cut',
    name: 'Cutting classes',
    categoryId: 'cat-attendance',
    levelId: 'lvl-moderate',
    actionIds: [
      'act-written-warning',
      'act-parent-conference',
      'act-detention',
    ],
    description: 'Skipping a scheduled class.',
  ),
  Offense(
    id: 'offense-uniform',
    name: 'Improper uniform',
    categoryId: 'cat-uniform',
    levelId: 'lvl-minor',
    actionIds: ['act-verbal-warning'],
    description: 'Incomplete or non-regulation uniform.',
  ),
  Offense(
    id: 'offense-phone',
    name: 'Using phone in class',
    categoryId: 'cat-conduct',
    levelId: 'lvl-minor',
    actionIds: ['act-verbal-warning', 'act-written-warning'],
    description: 'Device usage during instructional time.',
  ),
  Offense(
    id: 'offense-vandalism',
    name: 'Vandalism',
    categoryId: 'cat-property',
    levelId: 'lvl-serious',
    actionIds: ['act-parent-conference', 'act-detention', 'act-suspension'],
    description: 'Damaging school property.',
  ),
  Offense(
    id: 'offense-fighting',
    name: 'Physical fighting',
    categoryId: 'cat-violence',
    levelId: 'lvl-severe',
    actionIds: ['act-parent-conference', 'act-suspension'],
    description: 'Physical altercation with another student.',
  ),
  Offense(
    id: 'offense-bullying',
    name: 'Bullying',
    categoryId: 'cat-violence',
    levelId: 'lvl-critical',
    actionIds: ['act-parent-conference', 'act-suspension', 'act-expulsion'],
    description: 'Repeated physical, verbal, or social harm.',
  ),
];
