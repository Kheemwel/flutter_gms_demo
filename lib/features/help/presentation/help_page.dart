import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/help_section.dart';
import 'package:flutter_gms_demo/features/help/data/help_content.dart';
import 'package:flutter_gms_demo/features/help/presentation/widgets/help_content_pane.dart';
import 'package:flutter_gms_demo/features/help/presentation/widgets/help_nav_pane.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

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

    return AppPageScaffold(
      title: 'User Manual',
      subtitle: 'Everything you need to use this app, organised by feature.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Left nav ─────────────────────────────────────────────
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              border: Border(
                right: BorderSide(color: context.colorScheme.outlineVariant),
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
          // ── Content pane ─────────────────────────────────────────
          Expanded(
            child: HelpContentPane(
              section: selectedSection,
              subsection: selectedSubsection,
            ),
          ),
        ],
      ),
    );
  }
}
