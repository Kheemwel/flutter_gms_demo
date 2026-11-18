import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/widgets/calendar_tab.dart';
import 'package:flutter_gms_demo/features/guidance_program/presentation/widgets/schedule_tags_tab.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_notifier.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_providers.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class GuidanceProgramPage extends ConsumerWidget {
  const GuidanceProgramPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool canAdmin = ref.can(Privilege.admin);
    final int visibleEvents = ref.watch(visibleProgramsProvider).length;
    final int tagCount = ref.watch(guidanceScheduleTagsProvider).length;

    return AppPageScaffold(
      title: 'Guidance Program',
      subtitle:
          'School-wide activities, meetings, and private schedules. '
          'Private schedules are only visible to the invited users.',
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'Calendar', count: visibleEvents),
          if (canAdmin) AppTabSpec(label: 'Schedule Tags', count: tagCount),
        ],
        children: [const CalendarTab(), if (canAdmin) const ScheduleTagsTab()],
      ),
    );
  }
}
