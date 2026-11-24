import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/grade_level.dart';
import 'package:flutter_gms_demo/core/models/student_records.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/student_records/providers/student_records_notifier.dart';

Future<StudentIndividualInventory?> showInventoryFormDialog(
  BuildContext context, {
  required UserAccount student,
  StudentIndividualInventory? existing,
}) {
  return showDialog<StudentIndividualInventory>(
    context: context,
    builder: (_) => _InventoryFormDialog(student: student, existing: existing),
  );
}

class _InventoryFormDialog extends HookConsumerWidget {
  const _InventoryFormDialog({required this.student, this.existing});

  final UserAccount student;
  final StudentIndividualInventory? existing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController middleNameCtrl = useTextEditingController(
      text: existing?.middleName ?? '',
    );
    final TextEditingController addressCtrl = useTextEditingController(
      text: existing?.address ?? '',
    );
    final TextEditingController religionCtrl = useTextEditingController(
      text: existing?.religion ?? '',
    );
    final TextEditingController nationalityCtrl = useTextEditingController(
      text: existing?.nationality ?? '',
    );
    final TextEditingController fatherNameCtrl = useTextEditingController(
      text: existing?.fatherName ?? '',
    );
    final TextEditingController fatherContactCtrl = useTextEditingController(
      text: existing?.fatherContact ?? '',
    );
    final TextEditingController fatherOccupationCtrl = useTextEditingController(
      text: existing?.fatherOccupation ?? '',
    );
    final TextEditingController motherNameCtrl = useTextEditingController(
      text: existing?.motherName ?? '',
    );
    final TextEditingController motherContactCtrl = useTextEditingController(
      text: existing?.motherContact ?? '',
    );
    final TextEditingController motherOccupationCtrl = useTextEditingController(
      text: existing?.motherOccupation ?? '',
    );
    final TextEditingController guardianNameCtrl = useTextEditingController(
      text: existing?.guardianName ?? '',
    );
    final TextEditingController guardianContactCtrl = useTextEditingController(
      text: existing?.guardianContact ?? '',
    );
    final TextEditingController guardianRelationCtrl = useTextEditingController(
      text: existing?.guardianRelation ?? '',
    );
    final TextEditingController healthConditionsCtrl = useTextEditingController(
      text: existing?.healthConditions ?? '',
    );
    final TextEditingController allergiesCtrl = useTextEditingController(
      text: existing?.allergies ?? '',
    );
    final TextEditingController medicationsCtrl = useTextEditingController(
      text: existing?.medications ?? '',
    );
    final TextEditingController previousSchoolCtrl = useTextEditingController(
      text: existing?.previousSchool ?? '',
    );
    final TextEditingController generalAverageCtrl = useTextEditingController(
      text: existing?.generalAverage ?? '',
    );

    final ValueNotifier<DateTime?> birthday = useState<DateTime?>(existing?.birthday);
    final ValueNotifier<GradeLevel?> previousGradeLevel = useState<GradeLevel?>(
      existing?.previousGradeLevel,
    );
    final ValueNotifier<bool> submitting = useState(false);

    Future<void> save() async {
      submitting.value = true;

      final UserAccount? me = ref.read(authProvider);
      final String id = existing?.id ?? 'inv-${DateTime.now().microsecondsSinceEpoch}';

      final updated = StudentIndividualInventory(
        id: id,
        studentId: student.id,
        middleName: _nonEmpty(middleNameCtrl.text),
        address: _nonEmpty(addressCtrl.text),
        birthday: birthday.value,
        religion: _nonEmpty(religionCtrl.text),
        nationality: _nonEmpty(nationalityCtrl.text),
        fatherName: _nonEmpty(fatherNameCtrl.text),
        fatherContact: _nonEmpty(fatherContactCtrl.text),
        fatherOccupation: _nonEmpty(fatherOccupationCtrl.text),
        motherName: _nonEmpty(motherNameCtrl.text),
        motherContact: _nonEmpty(motherContactCtrl.text),
        motherOccupation: _nonEmpty(motherOccupationCtrl.text),
        guardianName: _nonEmpty(guardianNameCtrl.text),
        guardianContact: _nonEmpty(guardianContactCtrl.text),
        guardianRelation: _nonEmpty(guardianRelationCtrl.text),
        healthConditions: _nonEmpty(healthConditionsCtrl.text),
        allergies: _nonEmpty(allergiesCtrl.text),
        medications: _nonEmpty(medicationsCtrl.text),
        previousSchool: _nonEmpty(previousSchoolCtrl.text),
        previousGradeLevel: previousGradeLevel.value,
        generalAverage: _nonEmpty(generalAverageCtrl.text),
      );

      await ref.read(studentInventoriesProvider.notifier).save(updated);

      if (me != null) {
        ref
            .read(auditLogsProvider.notifier)
            .log(
              userAccountId: me.id,
              userFullName: me.fullName,
              action: existing == null
                  ? 'Create Student Inventory'
                  : 'Update Student Inventory',
              description:
                  '${me.fullName} ${existing == null ? 'created' : 'updated'} '
                  'the inventory for ${student.fullName}.',
            );
      }

      submitting.value = false;
      if (context.mounted) Navigator.of(context).pop(updated);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 800),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          existing == null
                              ? 'Add student inventory'
                              : 'Edit student inventory',
                          style: context.textTheme.titleLarge,
                        ),
                        Text(
                          student.fullName,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _SectionHeader('Basic information'),
                    _Field(label: 'Middle name', controller: middleNameCtrl),
                    _DateField(
                      label: 'Birthday',
                      value: birthday.value,
                      onChanged: (d) => birthday.value = d,
                    ),
                    _Field(
                      label: 'Address',
                      controller: addressCtrl,
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: 'Religion',
                            controller: religionCtrl,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Field(
                            label: 'Nationality',
                            controller: nationalityCtrl,
                          ),
                        ),
                      ],
                    ),

                    const _SectionHeader('Family'),
                    _Field(label: "Father's name", controller: fatherNameCtrl),
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: "Father's contact",
                            controller: fatherContactCtrl,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Field(
                            label: "Father's occupation",
                            controller: fatherOccupationCtrl,
                          ),
                        ),
                      ],
                    ),
                    _Field(label: "Mother's name", controller: motherNameCtrl),
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: "Mother's contact",
                            controller: motherContactCtrl,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Field(
                            label: "Mother's occupation",
                            controller: motherOccupationCtrl,
                          ),
                        ),
                      ],
                    ),
                    _Field(
                      label: "Guardian's name",
                      controller: guardianNameCtrl,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: "Guardian's contact",
                            controller: guardianContactCtrl,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _Field(
                            label: 'Relationship',
                            controller: guardianRelationCtrl,
                          ),
                        ),
                      ],
                    ),

                    const _SectionHeader('Health'),
                    _Field(
                      label: 'Health conditions',
                      controller: healthConditionsCtrl,
                      maxLines: 2,
                    ),
                    _Field(
                      label: 'Allergies',
                      controller: allergiesCtrl,
                      maxLines: 2,
                    ),
                    _Field(
                      label: 'Medications',
                      controller: medicationsCtrl,
                      maxLines: 2,
                    ),

                    const _SectionHeader('Academic background'),
                    _Field(
                      label: 'Previous school',
                      controller: previousSchoolCtrl,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<GradeLevel?>(
                      initialValue: previousGradeLevel.value,
                      decoration: const InputDecoration(
                        labelText: 'Previous grade level',
                        prefixIcon: Icon(Icons.school_outlined),
                      ),
                      items: [
                        const DropdownMenuItem<GradeLevel?>(
                          value: null,
                          child: Text('Not specified'),
                        ),
                        for (final g in GradeLevel.values)
                          DropdownMenuItem<GradeLevel?>(
                            value: g,
                            child: Text(g.label),
                          ),
                      ],
                      onChanged: (v) => previousGradeLevel.value = v,
                    ),
                    const SizedBox(height: 12),
                    _Field(
                      label: 'General average',
                      controller: generalAverageCtrl,
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: submitting.value
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submitting.value ? null : save,
                    child: submitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(existing == null ? 'Create' : 'Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String? _nonEmpty(String s) {
    final String t = s.trim();
    return t.isEmpty ? null : t;
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 12),
      child: Text(title, style: context.textTheme.titleSmall),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final display = value == null
        ? 'Not set'
        : '${value!.year}-${value!.month.toString().padLeft(2, '0')}-'
              '${value!.day.toString().padLeft(2, '0')}';
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime(2008),
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
          );
          if (picked != null) onChanged(picked);
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.event_rounded),
            suffixIcon: value == null
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () => onChanged(null),
                  ),
          ),
          child: Text(
            display,
            style: value == null
                ? context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  )
                : context.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
