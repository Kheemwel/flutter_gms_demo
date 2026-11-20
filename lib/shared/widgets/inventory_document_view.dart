import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';

class InventoryDocumentView extends StatelessWidget {
  const InventoryDocumentView({
    super.key,
    required this.inventory,
    this.studentName,
    this.studentLrn,
  });

  final StudentIndividualInventory? inventory;
  final String? studentName;
  final String? studentLrn;

  @override
  Widget build(BuildContext context) {
    if (inventory == null) {
      return const AppEmptyState(
        icon: Icons.assignment_outlined,
        title: 'No inventory yet',
        message:
            'The guidance office hasn\'t recorded this student\'s '
            'individual inventory.',
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeaderRow(
              title: studentName ?? 'Student',
              subtitle: studentLrn == null ? null : 'LRN ${studentLrn!}',
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Basic information',
              rows: [
                ('Middle name', inventory!.middleName),
                ('Birthday', _fmtDate(inventory!.birthday)),
                ('Address', inventory!.address),
                ('Religion', inventory!.religion),
                ('Nationality', inventory!.nationality),
              ],
            ),
            _Section(
              title: 'Family',
              rows: [
                ('Father', inventory!.fatherName),
                ('Father\'s contact', inventory!.fatherContact),
                ('Father\'s occupation', inventory!.fatherOccupation),
                ('Mother', inventory!.motherName),
                ('Mother\'s contact', inventory!.motherContact),
                ('Mother\'s occupation', inventory!.motherOccupation),
                ('Guardian', inventory!.guardianName),
                ('Guardian\'s contact', inventory!.guardianContact),
                ('Relationship', inventory!.guardianRelation),
              ],
            ),
            _Section(
              title: 'Health',
              rows: [
                ('Conditions', inventory!.healthConditions),
                ('Allergies', inventory!.allergies),
                ('Medications', inventory!.medications),
              ],
            ),
            _Section(
              title: 'Academic background',
              rows: [
                ('Previous school', inventory!.previousSchool),
                ('Previous level', inventory!.previousGradeLevel?.label),
                ('General average', inventory!.generalAverage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? _fmtDate(DateTime? d) {
    if (d == null) return null;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: context.colorScheme.primaryContainer,
          child: Icon(
            Icons.person_outline_rounded,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.titleLarge),
              if (subtitle != null)
                Text(subtitle!, style: context.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.rows});
  final String title;
  final List<(String, String?)> rows;

  @override
  Widget build(BuildContext context) {
    final bool hasAny = rows.any((r) => (r.$2 ?? '').isNotEmpty);
    if (!hasAny) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          const SizedBox(height: 6),
          for (final (label, value) in rows)
            if ((value ?? '').isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Text(label, style: context.textTheme.bodySmall),
                    ),
                    Expanded(
                      child: Text(value!, style: context.textTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}
