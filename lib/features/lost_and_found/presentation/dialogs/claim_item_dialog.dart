import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/lost_and_found.dart';
import 'package:flutter_gms_demo/features/lost_and_found/providers/lost_and_found_notifier.dart';

/// Returns true if the item was claimed.
Future<bool> showClaimDialog(
  BuildContext context, {
  required LostAndFoundItem item,
}) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (_) => _ClaimDialog(item: item),
  );
  return result ?? false;
}

class _ClaimDialog extends HookConsumerWidget {
  const _ClaimDialog({required this.item});

  final LostAndFoundItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameCtrl = useTextEditingController();
    final TextEditingController contactCtrl = useTextEditingController();
    final TextEditingController emailCtrl = useTextEditingController();
    final TextEditingController addressCtrl = useTextEditingController();
    final ValueNotifier<DateTime> claimedAt = useState<DateTime>(DateTime.now());
    final ValueNotifier<Map<String, String>> errors = useState<Map<String, String>>(const {});

    Future<void> submit() async {
      final e = <String, String>{};
      if (nameCtrl.text.trim().isEmpty) e['name'] = 'Required.';
      final String contact = contactCtrl.text.trim();
      if (!RegExp(r'^\d{11}$').hasMatch(contact)) {
        e['contact'] = 'Enter an 11-digit phone number.';
      }
      final String email = emailCtrl.text.trim();
      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
        e['email'] = 'Enter a valid email.';
      }
      if (addressCtrl.text.trim().isEmpty) e['address'] = 'Required.';
      if (e.isNotEmpty) {
        errors.value = e;
        return;
      }

      await ref
          .read(lostAndFoundItemsProvider.notifier)
          .claim(
            id: item.id,
            claimedDatetime: claimedAt.value,
            claimerName: nameCtrl.text.trim(),
            claimerContact: contact,
            claimerEmail: email,
            claimerAddress: addressCtrl.text.trim(),
          );
      if (context.mounted) Navigator.of(context).pop(true);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
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
                      'Claim "${item.itemName}"',
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
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Fill in the person picking up this item.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _field('Claimer name', nameCtrl, errors.value['name']),
                    _field(
                      'Contact number',
                      contactCtrl,
                      errors.value['contact'],
                      keyboard: TextInputType.phone,
                    ),
                    _field(
                      'Email',
                      emailCtrl,
                      errors.value['email'],
                      keyboard: TextInputType.emailAddress,
                    ),
                    _field(
                      'Address',
                      addressCtrl,
                      errors.value['address'],
                      maxLines: 2,
                    ),
                    InkWell(
                      onTap: () async {
                        final DateTime? d = await showDatePicker(
                          context: context,
                          initialDate: claimedAt.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (d != null) claimedAt.value = d;
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Claim date',
                          prefixIcon: Icon(Icons.event_available_rounded),
                        ),
                        child: Text(
                          '${claimedAt.value.year}-'
                          '${claimedAt.value.month.toString().padLeft(2, '0')}-'
                          '${claimedAt.value.day.toString().padLeft(2, '0')}',
                        ),
                      ),
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
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: submit,
                    child: const Text('Mark claimed'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl,
    String? error, {
    TextInputType? keyboard,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboard,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, errorText: error),
      ),
    );
  }
}
