import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/student_records/presentation/student_detail_dialog.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_data_table.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class StudentsPage extends ConsumerWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserAccount> students = ref.watch(filteredStudentsProvider);
    final String search = ref.watch(studentSearchProvider);
    final GradeLevel? grade = ref.watch(studentGradeFilterProvider);

    return AppPageScaffold(
      title: 'Students',
      subtitle:
          'All enrolled students. Open a student to view their '
          'individual inventory and anecdotal record.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search by name, email, or LRN…',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: (v) =>
                      ref.read(studentSearchProvider.notifier).state = v,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 220,
                child: DropdownButtonFormField<GradeLevel?>(
                  initialValue: grade,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.filter_alt_outlined),
                  ),
                  items: [
                    const DropdownMenuItem<GradeLevel?>(
                      value: null,
                      child: Text('All grade levels'),
                    ),
                    for (final g in GradeLevel.values)
                      DropdownMenuItem<GradeLevel?>(
                        value: g,
                        child: Text(g.label),
                      ),
                  ],
                  onChanged: (v) =>
                      ref.read(studentGradeFilterProvider.notifier).state = v,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: students.isEmpty
                ? AppEmptyState(
                    icon: Icons.school_outlined,
                    title: search.isEmpty
                        ? 'No students yet'
                        : 'No students match "$search"',
                    message: search.isEmpty
                        ? 'Students appear here after their account is created.'
                        : 'Try a different search or filter.',
                  )
                : AppDataTable<UserAccount>(
                    columns: const [
                      AppDataTableColumn(label: 'Name'),
                      AppDataTableColumn(label: 'LRN'),
                      AppDataTableColumn(label: 'Grade'),
                      AppDataTableColumn(label: 'Email'),
                      AppDataTableColumn(label: ''),
                    ],
                    onRowTap: (s) => _open(context, s),
                    rows: [
                      for (final s in students)
                        AppDataRow<UserAccount>(
                          payload: s,
                          cells: [
                            Text(s.fullName),
                            Text((s.profile as StudentProfile).lrn),
                            Text(
                              (s.profile as StudentProfile).gradeLevel.label,
                            ),
                            Text(s.email),
                            IconButton(
                              tooltip: 'Open',
                              icon: const Icon(Icons.open_in_new_rounded),
                              onPressed: () => _open(context, s),
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _open(BuildContext context, UserAccount student) async {
    await showDialog<void>(
      context: context,
      builder: (_) => StudentDetailDialog(studentId: student.id),
    );
  }
}
