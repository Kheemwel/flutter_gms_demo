import 'package:flutter/services.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/signatures/presentation/signature_pad_dialog.dart';
import 'package:flutter_gms_demo/shared/widgets/signature_preview.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_providers.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';

Future<void> showFillFormDialog(BuildContext context, {required Form form}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _FillFormDialog(formId: form.id),
  );
}

class _FillFormDialog extends HookConsumerWidget {
  const _FillFormDialog({required this.formId});

  final String formId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Form? form = ref.watch(
      formsProvider.select(
        (forms) => forms.where((f) => f.id == formId).firstOrNull,
      ),
    );
    if (form == null) {
      // Form was deleted while dialog was open.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) Navigator.of(context).maybePop();
      });
      return const SizedBox.shrink();
    }

    final SignerRole? signerRole = ref.watch(mySignerRoleForFormProvider(form));
    final UserAccount? me = ref.watch(authProvider);
    final Set<String> editableKeys = signerRole == null
        ? const <String>{}
        : (Form.editableFieldKeysFor(form.formType, signerRole) ??
              const <String>{});

    // "Can the user fill fields" — depends on having editable fields.
    final bool canEditFields =
        form.status == FormStatus.incomplete && editableKeys.isNotEmpty;

    // "Can the user sign" — independent of whether they have fields.
    // Any required signer on an incomplete form can sign their slot.
    final bool canSign =
        form.status == FormStatus.incomplete &&
        signerRole != null &&
        Form.requiredSignersFor(form.formType).contains(signerRole);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 800),
        child: _FormBody(
          form: form,
          signerRole: signerRole,
          editableKeys: editableKeys,
          canEditFields: canEditFields,
          canSign: canSign,
          meId: me?.id,
          meFullName: me?.fullName,
        ),
      ),
    );
  }
}

class _FormBody extends HookConsumerWidget {
  const _FormBody({
    required this.form,
    required this.signerRole,
    required this.editableKeys,
    required this.canEditFields,
    required this.canSign,
    required this.meId,
    required this.meFullName,
  });

  final Form form;
  final SignerRole? signerRole;
  final Set<String> editableKeys;
  final bool canEditFields;
  final bool canSign;
  final String? meId;
  final String? meFullName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, String> currentFields = switch (form.data) {
      HomeVisitationFormData d => d.fields,
      ViolationFormData d => d.fields,
    };
    final Map<SignerRole, String> currentSignatures = switch (form.data) {
      HomeVisitationFormData d => d.signatures,
      ViolationFormData d => d.signatures,
    };

    // Local editing state mirrors `currentFields` but allows edits
    // before saving.
    final ValueNotifier<Map<String, String>> localFields =
        useState<Map<String, String>>({...currentFields});
    final ValueNotifier<Map<String, String>> errors =
        useState<Map<String, String>>(const {});
    final ValueNotifier<bool> submitting = useState(false);

    final List<FormFieldSpec> fieldSpecs = Form.fieldsFor(form.formType);
    final Set<SignerRole> requiredSigners = Form.requiredSignersFor(
      form.formType,
    );

    final Map<String, TextEditingController> controllers = useMemoized(() {
      return {
        for (final spec in fieldSpecs)
          spec.key: TextEditingController(text: currentFields[spec.key] ?? ''),
      };
    }, [fieldSpecs]);

    useEffect(() {
      return () {
        for (final TextEditingController c in controllers.values) {
          c.dispose();
        }
      };
    }, [controllers]);

    Future<void> save() async {
      final e = <String, String>{};
      for (final spec in fieldSpecs) {
        if (!spec.required) continue;
        if (!editableKeys.contains(spec.key)) continue;
        final String v = localFields.value[spec.key] ?? '';
        if (v.trim().isEmpty) {
          e[spec.key] = 'Required.';
        }
      }
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }
      errors.value = const {};
      submitting.value = true;

      await ref
          .read(formsProvider.notifier)
          .mergeFields(formId: form.id, updates: localFields.value);

      if (meId != null) {
        ref
            .read(auditLogsProvider.notifier)
            .log(
              userAccountId: meId!,
              userFullName: meFullName,
              action: 'Edit Form',
              description:
                  '${form.displayId}: ${signerRole?.label ?? 'participant'} '
                  'updated fields.',
            );
      }

      // Re-read post-update to decide if completing.
      final Form updated = ref
          .read(formsProvider)
          .firstWhere((f) => f.id == form.id);
      if (updated.status == FormStatus.complete &&
          form.status != FormStatus.complete) {
        if (meId != null) {
          ref
              .read(auditLogsProvider.notifier)
              .log(
                userAccountId: meId!,
                userFullName: meFullName,
                action: 'Complete Form',
                description:
                    '${updated.displayId} (${updated.formType.label}) was completed.',
              );
        }

        final List<String> notifyIds = updated.participants
            .where((p) => p != meId)
            .toList();
        if (notifyIds.isNotEmpty && meId != null) {
          ref
              .read(appNotificationsProvider.notifier)
              .notifyMany(
                toUserIds: notifyIds,
                fromUserId: meId!,
                message: '${updated.displayId} is now complete.',
              );
        }
      }

      submitting.value = false;
      if (context.mounted) Navigator.of(context).pop();
    }

    Future<void> sign() async {
      if (signerRole == null || meId == null) return;

      final String? dataUrl = await showSignatureDialog(context);
      if (dataUrl == null || !context.mounted) return;

      await ref
          .read(formsProvider.notifier)
          .setSignature(
            formId: form.id,
            role: signerRole!,
            signatureDataUrl: dataUrl,
          );

      if (meId != null) {
        ref
            .read(auditLogsProvider.notifier)
            .log(
              userAccountId: meId!,
              userFullName: meFullName,
              action: 'Sign Form',
              description: '${form.displayId}: ${signerRole!.label} signed.',
            );
      }

      final Form updated = ref
          .read(formsProvider)
          .firstWhere((f) => f.id == form.id);
      if (updated.status == FormStatus.complete &&
          form.status != FormStatus.complete) {
        ref
            .read(auditLogsProvider.notifier)
            .log(
              userAccountId: meId!,
              userFullName: meFullName,
              action: 'Complete Form',
              description:
                  '${updated.displayId} (${updated.formType.label}) was completed.',
            );

        final List<String> notifyIds = updated.participants
            .where((p) => p != meId)
            .toList();
        if (notifyIds.isNotEmpty) {
          ref
              .read(appNotificationsProvider.notifier)
              .notifyMany(
                toUserIds: notifyIds,
                fromUserId: meId!,
                message: '${updated.displayId} is now complete.',
              );
        }
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(
          form: form,
          canEditFields: canEditFields,
          canSign: canSign,
          signerRole: signerRole,
        ),
        const Divider(height: 1),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Status chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: Icon(
                        form.status == FormStatus.complete
                            ? Icons.check_circle_rounded
                            : Icons.pending_outlined,
                        size: 16,
                      ),
                      label: Text(
                        form.status == FormStatus.complete
                            ? 'Completed'
                            : 'In progress',
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.people_alt_outlined, size: 16),
                      label: Text('${form.participants.length} participant(s)'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Form fields
                ...fieldSpecs.map((spec) {
                  final bool canEdit =
                      canEditFields && editableKeys.contains(spec.key);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: canEdit
                        ? _FormFieldInput(
                            spec: spec,
                            value: localFields.value[spec.key] ?? '',
                            errorText: errors.value[spec.key],
                            controller: controllers[spec.key]!,
                            onChanged: (v) {
                              final Map<String, String> next = {
                                ...localFields.value,
                              };
                              next[spec.key] = v;
                              localFields.value = next;
                            },
                          )
                        : _ReadOnlyField(
                            label: spec.label,
                            value: localFields.value[spec.key] ?? '',
                            required: spec.required,
                            type: spec.type,
                          ),
                  );
                }),

                // Signatures
                if (requiredSigners.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text('Signatures', style: context.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  for (final role in requiredSigners)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _SignatureRow(
                        role: role,
                        signed: (currentSignatures[role] ?? '').isNotEmpty,
                        signatureDataUrl: currentSignatures[role],
                        canSign:
                            canSign &&
                            signerRole == role &&
                            (currentSignatures[role] ?? '').isEmpty,
                        onSign: sign,
                      ),
                    ),
                ],
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
                child: Text(canEditFields ? 'Cancel' : 'Close'),
              ),
              if (canEditFields) ...[
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: submitting.value ? null : save,
                  child: submitting.value
                      ? const SizedBox(width: 18, height: 18)
                      : const Text('Save changes'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.form,
    required this.canEditFields,
    required this.canSign,
    required this.signerRole,
  });

  final Form form;
  final bool canEditFields;
  final bool canSign;
  final SignerRole? signerRole;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 16, 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.primaryContainer,
            child: Icon(
              form.formType == FormType.violation
                  ? Icons.gavel_rounded
                  : Icons.home_work_rounded,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${form.displayId} · ${form.formType.label}',
                  style: context.textTheme.titleLarge,
                ),
                Text(_subtitle(), style: context.textTheme.bodySmall),
              ],
            ),
          ),
          if (signerRole != null)
            Chip(
              avatar: const Icon(Icons.person_pin_rounded, size: 16),
              label: Text('You: ${signerRole!.label}'),
            ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  String _subtitle() {
    if (form.status == FormStatus.complete) return 'Read-only view.';
    final canDo = <String>[
      if (canEditFields) 'fill your fields',
      if (canSign) 'sign',
    ];
    if (canDo.isEmpty) return 'Read-only view.';
    return 'You can ${canDo.join(' and ')} to move this forward.';
  }
}

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({
    required this.label,
    required this.value,
    required this.required,
    this.type = FormFieldType.text,
  });

  final String label;
  final String value;
  final bool required;
  final FormFieldType type;

  @override
  Widget build(BuildContext context) {
    final bool empty = value.trim().isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.25,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(
              '$label${required ? ' *' : ''}',
              style: context.textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Text(
              empty ? '—' : value,
              style: context.textTheme.bodyMedium?.copyWith(
                color: empty
                    ? context.colorScheme.onSurfaceVariant
                    : context.colorScheme.onSurface,
                fontStyle: empty ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.errorText,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final DateTime? current = _parseDate(value);
    final String display = current == null ? 'Pick a date' : _fmtDate(current);

    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: current ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) onChanged(_fmtDate(picked));
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.event_rounded),
          errorText: errorText,
          suffixIcon: current == null
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () => onChanged(''),
                ),
        ),
        child: Text(
          display,
          style: current == null
              ? context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                )
              : context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  DateTime? _parseDate(String v) {
    if (v.isEmpty) return null;
    return DateTime.tryParse(v);
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.errorText,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final TimeOfDay? current = _parseTime(value);
    final String display = current == null ? 'Pick a time' : _fmtTime(current);

    return InkWell(
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: current ?? TimeOfDay.now(),
        );
        if (picked != null) onChanged(_fmtTime(picked));
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.schedule_rounded),
          errorText: errorText,
          suffixIcon: current == null
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: () => onChanged(''),
                ),
        ),
        child: Text(
          display,
          style: current == null
              ? context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                )
              : context.textTheme.bodyMedium,
        ),
      ),
    );
  }

  TimeOfDay? _parseTime(String v) {
    if (v.isEmpty) return null;
    final List<String> parts = v.split(':');
    if (parts.length != 2) return null;
    final int? h = int.tryParse(parts[0]);
    final int? m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return TimeOfDay(hour: h, minute: m);
  }

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}';
}

class _EnumerationField extends StatelessWidget {
  const _EnumerationField({
    required this.label,
    required this.value,
    required this.options,
    required this.errorText,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> options;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool hasCurrent = options.contains(value);
    return DropdownButtonFormField<String>(
      initialValue: hasCurrent ? value : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.list_rounded),
        errorText: errorText,
      ),
      hint: const Text('Select…'),
      items: [
        for (final o in options) DropdownMenuItem(value: o, child: Text(o)),
      ],
      onChanged: (v) => onChanged(v ?? ''),
    );
  }
}

class _SignatureRow extends StatelessWidget {
  const _SignatureRow({
    required this.role,
    required this.signed,
    required this.signatureDataUrl,
    required this.canSign,
    required this.onSign,
  });

  final SignerRole role;
  final bool signed;
  final String? signatureDataUrl;
  final bool canSign;
  final VoidCallback onSign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.25,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(role.label, style: context.textTheme.bodySmall),
          ),
          Expanded(
            child: signed && signatureDataUrl != null
                ? Row(
                    children: [
                      SignaturePreview(
                        dataUrl: signatureDataUrl!,
                        width: 96,
                        height: 36,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Signed',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Awaiting signature',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
          ),
          if (canSign)
            FilledButton.tonalIcon(
              onPressed: onSign,
              icon: const Icon(Icons.draw_rounded, size: 18),
              label: const Text('Sign'),
            ),
        ],
      ),
    );
  }
}

class _FormFieldInput extends StatelessWidget {
  const _FormFieldInput({
    required this.spec,
    required this.value,
    required this.errorText,
    required this.controller,
    required this.onChanged,
  });

  final FormFieldSpec spec;
  final String value;
  final String? errorText;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return switch (spec.type) {
      FormFieldType.text => TextField(
        controller: controller,
        decoration: InputDecoration(labelText: _label, errorText: errorText),
        onChanged: onChanged,
      ),
      FormFieldType.longText => TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: _label,
          alignLabelWithHint: true,
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
      FormFieldType.int => TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(labelText: _label, errorText: errorText),
        onChanged: onChanged,
      ),
      FormFieldType.date => _DateField(
        label: _label,
        value: value,
        errorText: errorText,
        onChanged: onChanged,
      ),
      FormFieldType.time => _TimeField(
        label: _label,
        value: value,
        errorText: errorText,
        onChanged: onChanged,
      ),
      FormFieldType.enumeration => _EnumerationField(
        label: _label,
        value: value,
        options: spec.options,
        errorText: errorText,
        onChanged: onChanged,
      ),
    };
  }

  String get _label => '${spec.label}${spec.required ? ' *' : ''}';
}
