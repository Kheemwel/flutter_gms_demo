import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';

class AppTabSpec {
  const AppTabSpec({required this.label, this.count});
  final String label;
  final int? count;
}

class AppTabs extends StatelessWidget {
  const AppTabs({super.key, required this.tabs, required this.children});

  final List<AppTabSpec> tabs;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.35,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(4),
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              labelColor: context.colorScheme.onSurface,
              unselectedLabelColor: context.colorScheme.onSurfaceVariant,
              labelStyle: context.textTheme.labelLarge,
              tabs: [
                for (final AppTabSpec spec in tabs)
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(spec.label),
                          if (spec.count != null) ...[
                            const SizedBox(width: 6),
                            _CountBadge(count: spec.count!),
                          ],
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: TabBarView(children: children)),
        ],
      ),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$count',
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
