import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:material_ui/material_ui.dart';

class SignaturePreview extends StatelessWidget {
  const SignaturePreview({
    super.key,
    required this.dataUrl,
    this.width = 80,
    this.height = 32,
  });

  final String dataUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final Uint8List? bytes = _decode(dataUrl);
    if (bytes == null) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 14,
          color: context.colorScheme.onSurfaceVariant,
        ),
      );
    }
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: Image.memory(
        bytes,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Uint8List? _decode(String dataUrl) {
    final int idx = dataUrl.indexOf(',');
    if (idx < 0) return null;
    final String payload = dataUrl.substring(idx + 1);
    try {
      return base64Decode(payload);
    } catch (_) {
      return null;
    }
  }
}
