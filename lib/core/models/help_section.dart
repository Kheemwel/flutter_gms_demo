import 'package:material_ui/material_ui.dart';

/// A top-level entry in the help/manual navigation tree.
/// Contains one or more [HelpSubsection]s.
class HelpSection {
  const HelpSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.subsections,
  });

  final String id;
  final String title;
  final IconData icon;
  final List<HelpSubsection> subsections;
}

/// A single page of the manual. Rendered in the content pane when
/// the user selects the corresponding entry in the left nav.
class HelpSubsection {
  const HelpSubsection({
    required this.id,
    required this.title,
    required this.description,
    this.steps = const <HelpStep>[],
    this.note,
    this.comingSoon = false,
  });

  final String id;
  final String title;

  /// Short overview shown above the step list.
  final String description;

  /// Ordered steps. When [comingSoon] is true this is normally empty.
  final List<HelpStep> steps;

  /// Optional informational footer (tips, caveats, related links).
  final String? note;

  /// When true, the subsection renders a "coming soon" banner instead
  /// of a step list. Used for features not yet available in this demo.
  final bool comingSoon;
}

class HelpStep {
  const HelpStep({
    required this.text,
    this.icon = Icons.check_circle_outline_rounded,
  });

  final String text;
  final IconData icon;
}
