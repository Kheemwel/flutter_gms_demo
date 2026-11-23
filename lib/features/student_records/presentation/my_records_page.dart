import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/anecdotal_list_view.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';
import 'package:flutter_gms_demo/shared/widgets/inventory_document_view.dart';

class MyRecordsPage extends ConsumerWidget {
  const MyRecordsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    if (me == null || me.profile is! StudentProfile) {
      return const AppEmptyState(
        icon: Icons.lock_outline_rounded,
        title: 'Not a student account',
        message: 'This page is only available for student accounts.',
      );
    }
    final profile = me.profile as StudentProfile;
    final StudentIndividualInventory? inventory = ref
        .watch(studentInventoriesProvider)
        .where((inv) => inv.studentId == me.id)
        .firstOrNull;

    return AppPageScaffold(
      title: 'My Records',
      subtitle:
          'Your individual inventory and anecdotal record. '
          'These are maintained by the guidance office.',
      child: AppTabs(
        tabs: const [
          AppTabSpec(label: 'My inventory'),
          AppTabSpec(label: 'My anecdotal record'),
        ],
        children: [
          SingleChildScrollView(
            child: InventoryDocumentView(
              inventory: inventory,
              studentName: me.fullName,
              studentLrn: profile.lrn,
            ),
          ),
          AnecdotalListView(
            studentId: me.id,
            viewerRole: AnecdotalViewerRole.student,
          ),
        ],
      ),
    );
  }
}
