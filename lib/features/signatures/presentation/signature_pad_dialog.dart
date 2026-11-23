import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:signature/signature.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';

/// Opens a signature pad and returns the resulting data URL
/// (`data:image/png;base64,...`), or `null` if the user cancels.
Future<String?> showSignatureDialog(BuildContext context) async {
  final String? dataUrl = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const _SignaturePadDialog(),
  );
  return dataUrl;
}

class _SignaturePadDialog extends HookWidget {
  const _SignaturePadDialog();

  @override
  Widget build(BuildContext context) {
    final SignatureController controller = useMemoized(
      () => SignatureController(
        penStrokeWidth: 3,
        penColor: context.colorScheme.onSurface,
        exportBackgroundColor: Colors.transparent,
      ),
      [context.colorScheme.onSurface],
    );

    useEffect(() {
      return () => controller.dispose();
    }, [controller]);

    final ValueNotifier<bool> isEmpty = useState(true);
    // Track ink changes to know when the "Save" button should enable.
    useEffect(() {
      void listener() => isEmpty.value = controller.isEmpty;
      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    Future<void> save() async {
      if (controller.isEmpty) return;
      final Uint8List? bytes = await controller.toPngBytes();
      if (bytes == null) return;
      final dataUrl = 'data:image/png;base64,${base64Encode(bytes)}';
      if (context.mounted) Navigator.of(context).pop(dataUrl);
    }

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 560),
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
                      'Sign here',
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
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: Text(
                'Draw your signature below with your finger or mouse.',
                style: context.textTheme.bodySmall,
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outlineVariant,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Signature(
                    controller: controller,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: isEmpty.value ? null : () => controller.clear(),
                    icon: const Icon(Icons.undo_rounded),
                    label: const Text('Clear'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: isEmpty.value ? null : save,
                    child: const Text('Save signature'),
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
