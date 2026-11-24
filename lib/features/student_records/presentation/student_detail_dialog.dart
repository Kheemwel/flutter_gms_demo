import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/features/student_records/presentation/dialogs/inventory_form_dialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/anecdotal_list_view.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';
import 'package:flutter_gms_demo/shared/widgets/inventory_document_view.dart';

class StudentDetailDialog extends ConsumerWidget {
  const StudentDetailDialog({
    super.key,
    required this.studentId,
    this.viewerRole = AnecdotalViewerRole.guidance,
  });

  final String studentId;
  final AnecdotalViewerRole viewerRole;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? student = ref.watch(userByIdProvider(studentId));
    if (student == null) {
      return const Dialog(child: SizedBox(width: 400, height: 200));
    }
    final profile = student.profile as StudentProfile;
    final StudentIndividualInventory? inventory = ref
        .watch(studentInventoriesProvider)
        .where((inv) => inv.studentId == studentId)
        .firstOrNull;

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900, maxHeight: 780),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.fullName,
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          '${profile.gradeLevel.label} · '
                          'LRN ${profile.lrn}',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: AppTabs(
                  tabs: const [
                    AppTabSpec(label: 'Individual inventory'),
                    AppTabSpec(label: 'Anecdotal record'),
                  ],
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (ref.can(Privilege.manageStudentInventory))
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: FilledButton.icon(
                                  onPressed: () async {
                                    final StudentIndividualInventory? created =
                                        await showInventoryFormDialog(
                                          context,
                                          student: student,
                                          existing: inventory,
                                        );
                                    if (created != null && context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                inventory == null
                                                    ? 'Inventory created.'
                                                    : 'Inventory updated.',
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  icon: Icon(
                                    inventory == null
                                        ? Icons.note_add_rounded
                                        : Icons.edit_rounded,
                                  ),
                                  label: Text(
                                    inventory == null
                                        ? 'Add inventory'
                                        : 'Edit inventory',
                                  ),
                                ),
                              ),
                            ),
                          InventoryDocumentView(
                            inventory: inventory,
                            studentName: student.fullName,
                            studentLrn: profile.lrn,
                          ),
                        ],
                      ),
                    ),
                    AnecdotalListView(
                      studentId: studentId,
                      viewerRole: viewerRole,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
