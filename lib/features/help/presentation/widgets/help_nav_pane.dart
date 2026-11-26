import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/help_section.dart';

class HelpNavPane extends StatefulWidget {
  const HelpNavPane({
    super.key,
    required this.sections,
    required this.selectedSectionId,
    required this.selectedSubsectionId,
    required this.onSectionSelected,
    required this.onSubsectionSelected,
  });

  final List<HelpSection> sections;
  final String selectedSectionId;
  final String selectedSubsectionId;
  final ValueChanged<HelpSection> onSectionSelected;
  final void Function(HelpSection, HelpSubsection) onSubsectionSelected;

  @override
  State<HelpNavPane> createState() => _HelpNavPaneState();
}

class _HelpNavPaneState extends State<HelpNavPane> {
  /// Which sections are currently expanded.
  late final Set<String> _expanded = {widget.selectedSectionId};

  @override
  void didUpdateWidget(HelpNavPane oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Auto-expand the selected section when the selection changes.
    if (oldWidget.selectedSectionId != widget.selectedSectionId) {
      _expanded.add(widget.selectedSectionId);
    }
  }

  void _toggle(HelpSection section) {
    setState(() {
      if (_expanded.contains(section.id)) {
        _expanded.remove(section.id);
      } else {
        _expanded.add(section.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [for (final section in widget.sections) _buildSection(section)],
    );
  }

  Widget _buildSection(HelpSection section) {
    final bool isOpen = _expanded.contains(section.id);
    final bool isActive = widget.selectedSectionId == section.id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: isActive && !isOpen
              ? context.colorScheme.secondaryContainer.withValues(alpha: 0.6)
              : Colors.transparent,
          child: InkWell(
            onTap: () => _toggle(section),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Icon(
                    section.icon,
                    size: 18,
                    color: isActive
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    isOpen
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 18,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isOpen)
          for (final sub in section.subsections) _buildSubsection(section, sub),
      ],
    );
  }

  Widget _buildSubsection(HelpSection section, HelpSubsection sub) {
    final bool isActive =
        widget.selectedSectionId == section.id &&
        widget.selectedSubsectionId == sub.id;

    return Material(
      color: isActive
          ? context.colorScheme.secondaryContainer.withValues(alpha: 0.6)
          : Colors.transparent,
      child: InkWell(
        onTap: () => widget.onSubsectionSelected(section, sub),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 46,
            right: 16,
            top: 8,
            bottom: 8,
          ),
          child: Text(
            sub.title,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? context.colorScheme.onSecondaryContainer
                  : context.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
