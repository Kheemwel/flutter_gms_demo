import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/anecdotal_list_view.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';
import 'package:flutter_gms_demo/shared/widgets/inventory_document_view.dart';

class MyChildRecordsPage extends ConsumerWidget {
  const MyChildRecordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<UserAccount> children = ref.watch(myChildrenProvider);
    if (children.isEmpty) {
      return const AppEmptyState(
        icon: Icons.family_restroom_rounded,
        title: 'No children on this account',
        message:
            'The guidance office hasn\'t linked any students to your '
            'parent account.',
      );
    }

    final String selectedId =
        ref.watch(selectedChildIdProvider) ?? children.first.id;
    final UserAccount selected = children.firstWhere(
      (c) => c.id == selectedId,
      orElse: () => children.first,
    );
    final profile = selected.profile as StudentProfile;
    final StudentIndividualInventory? inventory = ref
        .watch(studentInventoriesProvider.notifier)
        .forStudent(selected.id);

    return AppPageScaffold(
      title: 'My Child Records',
      subtitle:
          'View your child\'s individual inventory and anecdotal record. '
          'You can sign anecdotal entries routed to you.',
      actions: [
        if (children.length > 1)
          SizedBox(
            width: 220,
            child: DropdownButtonFormField<String>(
              initialValue: selected.id,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: 'Child',
              ),
              items: [
                for (final c in children)
                  DropdownMenuItem(value: c.id, child: Text(c.fullName)),
              ],
              onChanged: (v) =>
                  ref.read(selectedChildIdProvider.notifier).state = v,
            ),
          ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${selected.fullName} · ${profile.gradeLevel.label}',
            style: context.textTheme.titleSmall,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AppTabs(
              tabs: const [
                AppTabSpec(label: 'Individual inventory'),
                AppTabSpec(label: 'Anecdotal record'),
              ],
              children: [
                SingleChildScrollView(
                  child: InventoryDocumentView(
                    inventory: inventory,
                    studentName: selected.fullName,
                    studentLrn: profile.lrn,
                  ),
                ),
                AnecdotalListView(
                  studentId: selected.id,
                  viewerRole: AnecdotalViewerRole.parent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
