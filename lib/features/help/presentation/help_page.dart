import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/help_section.dart';
import 'package:flutter_gms_demo/features/help/data/help_content.dart';
import 'package:flutter_gms_demo/features/help/presentation/widgets/help_content_pane.dart';
import 'package:flutter_gms_demo/features/help/presentation/widgets/help_nav_pane.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

const double _kHelpBreakpoint = 900;

class HelpPage extends HookConsumerWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default to the first subsection of the first section.
    final ValueNotifier<String> selectedSectionId = useState<String>(
      helpSections.first.id,
    );
    final ValueNotifier<String> selectedSubsectionId = useState<String>(
      helpSections.first.subsections.first.id,
    );

    final HelpSection selectedSection = helpSections.firstWhere(
      (s) => s.id == selectedSectionId.value,
      orElse: () => helpSections.first,
    );
    final HelpSubsection selectedSubsection = selectedSection.subsections
        .firstWhere(
          (s) => s.id == selectedSubsectionId.value,
          orElse: () => selectedSection.subsections.first,
        );

    void selectSection(HelpSection section) {
      selectedSectionId.value = section.id;
      selectedSubsectionId.value = section.subsections.first.id;
    }

    void selectSubsection(HelpSection section, HelpSubsection sub) {
      selectedSectionId.value = section.id;
      selectedSubsectionId.value = sub.id;
    }

    Future<void> openTopicsSheet() async {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        backgroundColor: context.colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (sheetContext) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 1.0,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12, bottom: 8),
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: context.colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Header row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 4, 12, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Manual Topics',
                            style: context.textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close',
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Navigation list
                  Expanded(
                    child: HelpNavPane(
                      sections: helpSections,
                      selectedSectionId: selectedSectionId.value,
                      selectedSubsectionId: selectedSubsectionId.value,
                      onSectionSelected: selectSection,
                      onSubsectionSelected: (section, sub) {
                        selectSubsection(section, sub);
                        Navigator.of(sheetContext).pop();
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isNarrow = constraints.maxWidth < _kHelpBreakpoint;

        return AppPageScaffold(
          title: 'User Manual',
          subtitle:
              'Everything you need to use this app, organised by feature.',
          actions: [
            if (isNarrow)
              OutlinedButton.icon(
                onPressed: openTopicsSheet,
                icon: const Icon(Icons.menu_book_rounded, size: 18),
                label: const Text('Topics'),
              ),
          ],
          child: isNarrow
              ? Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                  child: HelpContentPane(
                    section: selectedSection,
                    subsection: selectedSubsection,
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── Left nav ───────────────────────────────────────────
                    Container(
                      width: 280,
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        border: Border(
                          right: BorderSide(
                            color: context.colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                      child: HelpNavPane(
                        sections: helpSections,
                        selectedSectionId: selectedSectionId.value,
                        selectedSubsectionId: selectedSubsectionId.value,
                        onSectionSelected: selectSection,
                        onSubsectionSelected: selectSubsection,
                      ),
                    ),
                    // ── Content pane ───────────────────────────────────────
                    Expanded(
                      child: HelpContentPane(
                        section: selectedSection,
                        subsection: selectedSubsection,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
