import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/privilege_x.dart';
import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/core/models/privilege.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_providers.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/widgets/item_table.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/widgets/tags_tab.dart';
import 'package:flutter_gms_demo/features/lost_and_found/presentation/widgets/types_tab.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';
import 'package:flutter_gms_demo/shared/widgets/app_tabs.dart';

class LostAndFoundPage extends ConsumerWidget {
  const LostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({int claimed, int expired, int found}) counts = ref.watch(
      lostFoundCountsProvider,
    );
    final bool canAdmin = ref.can(Privilege.admin);

    return AppPageScaffold(
      title: 'Lost & Found',
      subtitle:
          'Items found on campus. Items expire automatically based on '
          'their priority tag.',
      child: AppTabs(
        tabs: [
          AppTabSpec(label: 'Found', count: counts.found),
          AppTabSpec(label: 'Claimed', count: counts.claimed),
          AppTabSpec(label: 'Expired', count: counts.expired),
          if (canAdmin) const AppTabSpec(label: 'Types & Tags'),
        ],
        children: [
          const _ItemsTabBody(tab: LostFoundTab.found),
          const _ItemsTabBody(tab: LostFoundTab.claimed),
          const _ItemsTabBody(tab: LostFoundTab.expired),
          if (canAdmin) const _TypesAndTagsTabBody(),
        ],
      ),
    );
  }
}

class _ItemsTabBody extends ConsumerWidget {
  const _ItemsTabBody({required this.tab});
  final LostFoundTab tab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ItemType> types = ref.watch(itemTypesProvider);
    final String? typeFilter = ref.watch(lostFoundTypeFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search by item, location, or person…',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
                onChanged: (v) =>
                    ref.read(lostFoundSearchProvider.notifier).state = v,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 220,
              child: DropdownButtonFormField<String?>(
                initialValue: typeFilter,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.filter_alt_outlined),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('All types'),
                  ),
                  for (final t in types)
                    DropdownMenuItem<String?>(
                      value: t.id,
                      child: Text(t.itemType),
                    ),
                ],
                onChanged: (v) =>
                    ref.read(lostFoundTypeFilterProvider.notifier).state = v,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(child: ItemTable(tab: tab)),
      ],
    );
  }
}

class _TypesAndTagsTabBody extends ConsumerWidget {
  const _TypesAndTagsTabBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppTabs(
      tabs: [
        AppTabSpec(label: 'Types'),
        AppTabSpec(label: 'Priority tags'),
      ],
      children: [TypesTab(), TagsTab()],
    );
  }
}
