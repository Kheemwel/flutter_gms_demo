import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/features/offenses/presentation/widgets/actions_tab.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/widgets/categories_tab.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/widgets/levels_tab.dart';
import 'package:flutter_gms_demo/features/offenses/presentation/widgets/offenses_tab.dart';
import 'package:flutter_gms_demo/features/offenses/providers/offenses_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class OffensesPage extends ConsumerWidget {
  const OffensesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int offenseCount = ref.watch(offensesProvider).length;
    final int categoryCount = ref.watch(offenseCategoriesProvider).length;
    final int levelCount = ref.watch(offenseLevelsProvider).length;
    final int actionCount = ref.watch(disciplinaryActionsProvider).length;

    return AppPageScaffold(
      title: 'Offenses',
      subtitle:
          'Define offenses, their categories and severity levels, '
          'and the disciplinary actions that can be applied.',
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'Offenses', count: offenseCount),
          AppTabSpec(label: 'Categories', count: categoryCount),
          AppTabSpec(label: 'Levels', count: levelCount),
          AppTabSpec(label: 'Disciplinary Actions', count: actionCount),
        ],
        children: const [
          OffensesTab(),
          CategoriesTab(),
          LevelsTab(),
          DisciplinaryActionsTab(),
        ],
      ),
    );
  }
}
