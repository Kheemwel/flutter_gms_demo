import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';

Future<GuidanceProgram?> showEventForm(
  BuildContext context, {
  GuidanceProgram? existing,
  DateTime? initialDate,
}) {
  return showDialog<GuidanceProgram>(
    context: context,
    builder: (_) =>
        _EventFormDialog(existing: existing, initialDate: initialDate),
  );
}

class _EventFormDialog extends HookConsumerWidget {
  const _EventFormDialog({this.existing, this.initialDate});

  final GuidanceProgram? existing;
  final DateTime? initialDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GuidanceScheduleTag> tags = ref.watch(
      guidanceScheduleTagsProvider,
    );
    final UserAccount? me = ref.watch(authProvider);
    final List<UserAccount> users = ref.watch(userAccountsProvider);

    final DateTime anchor =
        existing?.programStart ?? initialDate ?? DateTime.now();
    final DateTime startHour =
        existing?.programStart ??
        DateTime(anchor.year, anchor.month, anchor.day, 9);
    final DateTime endHour =
        existing?.programEnd ??
        DateTime(anchor.year, anchor.month, anchor.day, 10);

    final TextEditingController titleCtrl = useTextEditingController(
      text: existing?.title ?? '',
    );
    final TextEditingController descCtrl = useTextEditingController(
      text: existing?.description ?? '',
    );
    final ValueNotifier<DateTime> startAt = useState<DateTime>(startHour);
    final ValueNotifier<DateTime> endAt = useState<DateTime>(endHour);
    final ValueNotifier<String?> tagId = useState<String?>(
      existing?.scheduleTagId ?? (tags.isNotEmpty ? tags.first.id : null),
    );
    final ValueNotifier<bool> isPublic = useState<bool>(
      existing?.isPublic ?? true,
    );
    final ValueNotifier<Set<String>> recipients = useState<Set<String>>(
      (existing?.privateRecipients ?? const <String>[]).toSet(),
    );
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});

    Future<void> submit() async {
      final e = <String, String>{};
      if (titleCtrl.text.trim().isEmpty) {
        e['title'] = 'Title is required.';
      }
      if (!endAt.value.isAfter(startAt.value)) {
        e['dates'] = 'End must be after start.';
      }
      if (tagId.value == null) {
        e['tag'] = 'Pick a schedule tag.';
      }
      if (!isPublic.value && recipients.value.isEmpty) {
        e['recipients'] = 'Pick at least one recipient.';
      }
      if (me == null) {
        e['_auth'] = 'Not logged in.';
      }
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};

      final List<String> finalRecipients = isPublic.value
          ? const <String>[]
          : {
              ...recipients.value,
              me!.id, // creator always included
            }.toList(growable: false);

      final program = GuidanceProgram(
        id: existing?.id ?? 'prog-${DateTime.now().microsecondsSinceEpoch}',
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        programStart: startAt.value,
        programEnd: endAt.value,
        scheduleTagId: tagId.value!,
        isPublic: isPublic.value,
        privateRecipients: finalRecipients,
        createdByUserId: existing?.createdByUserId ?? me!.id,
      );

      final GuidancePrograms notifier = ref.read(
        guidanceProgramsProvider.notifier,
      );
      if (existing == null) {
        await notifier.add(program);
      } else {
        await notifier.update(program);
      }

      // Fire notifications for private schedules.
      if (!program.isPublic && me != null) {
        final List<String> recipientsToNotify = program.privateRecipients
            .where((id) => id != me.id)
            .toList();
        if (recipientsToNotify.isNotEmpty) {
          ref
              .read(appNotificationsProvider.notifier)
              .notifyMany(
                toUserIds: recipientsToNotify,
                fromUserId: me.id,
                message: existing == null
                    ? 'New private schedule: "${program.title}"'
                    : 'Updated private schedule: "${program.title}"',
              );
        }
      }

      if (context.mounted) Navigator.of(context).pop(program);
    }

    final bool isSmall = MediaQuery.sizeOf(context).width < 720;

    final Widget scrollBody = SingleChildScrollView(
      padding: EdgeInsets.all(isSmall ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: titleCtrl,
            decoration: InputDecoration(
              labelText: 'Title',
              prefixIcon: const Icon(Icons.event_note_rounded),
              errorText: errors.value['title'],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descCtrl,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              prefixIcon: Icon(Icons.notes_rounded),
            ),
          ),
          const SizedBox(height: 12),
          _DateTimeField(
            label: 'Starts at',
            value: startAt.value,
            onChanged: (v) => startAt.value = v,
          ),
          _DateTimeField(
            label: 'Ends at',
            value: endAt.value,
            onChanged: (v) => endAt.value = v,
            error: errors.value['dates'],
          ),
          DropdownButtonFormField<String>(
            initialValue: tagId.value,
            decoration: InputDecoration(
              labelText: 'Schedule tag',
              prefixIcon: const Icon(Icons.label_outline_rounded),
              errorText: errors.value['tag'],
            ),
            items: [
              for (final t in tags)
                DropdownMenuItem(
                  value: t.id,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Color(t.colorValue),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(t.tagName),
                    ],
                  ),
                ),
            ],
            onChanged: (v) => tagId.value = v,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Public event'),
            subtitle: const Text(
              'Visible to all users. Turn off to invite '
              'specific users instead.',
            ),
            value: isPublic.value,
            onChanged: (v) => isPublic.value = v,
          ),
          if (!isPublic.value) ...[
            const SizedBox(height: 12),
            Text('Invite recipients', style: context.textTheme.titleSmall),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final u in users)
                    if (u.id != me?.id && !u.isArchived)
                      CheckboxListTile(
                        dense: true,
                        title: Text(u.fullName),
                        subtitle: Text(u.email),
                        value: recipients.value.contains(u.id),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (v) {
                          final next = Set<String>.from(recipients.value);
                          if (v ?? false) {
                            next.add(u.id);
                          } else {
                            next.remove(u.id);
                          }
                          recipients.value = next;
                        },
                      ),
                ],
              ),
            ),
            if (errors.value['recipients'] != null) ...[
              const SizedBox(height: 6),
              Text(
                errors.value['recipients']!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              'You will be added automatically.',
              style: context.textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
    if (isSmall) {
      return Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_rounded),
            ),
            title: Text(existing == null ? 'Add event' : 'Edit event'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilledButton(
                  onPressed: submit,
                  child: Text(existing == null ? 'Create' : 'Save'),
                ),
              ),
            ],
          ),
          body: scrollBody,
        ),
      );
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 780),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      existing == null ? 'Add event' : 'Edit event',
                      style: context.textTheme.titleLarge,
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
            Flexible(child: scrollBody),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submit,
                    child: Text(existing == null ? 'Create' : 'Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateTimeField extends StatelessWidget {
  const _DateTimeField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.error,
  });

  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          final DateTime? date = await showDatePicker(
            context: context,
            initialDate: value,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (date == null || !context.mounted) return;
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value),
          );
          if (time == null) return;
          onChanged(
            DateTime(date.year, date.month, date.day, time.hour, time.minute),
          );
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: const Icon(Icons.schedule_rounded),
            errorText: error,
          ),
          child: Text(_fmt(value)),
        ),
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')} '
      '${d.hour.toString().padLeft(2, '0')}:'
      '${d.minute.toString().padLeft(2, '0')}';
}
