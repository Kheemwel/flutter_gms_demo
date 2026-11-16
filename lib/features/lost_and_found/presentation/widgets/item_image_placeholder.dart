import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:material_ui/material_ui.dart';

class ItemImagePlaceholder extends StatelessWidget {
  const ItemImagePlaceholder({
    super.key,
    required this.seedId,
    this.size = 40,
    this.icon = Icons.search_rounded,
  });

  /// Used to hash into a stable pair of gradient colors.
  final String seedId;
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = _gradientFor(seedId, context.colorScheme);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.24),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Icon(
        icon,
        size: size * 0.5,
        color: Colors.white.withValues(alpha: 0.85),
      ),
    );
  }

  List<Color> _gradientFor(String seed, ColorScheme scheme) {
    final int hash = seed.codeUnits.fold<int>(0, (a, b) => a * 31 + b);
    final int bucket = hash.abs() % 4;
    return switch (bucket) {
      0 => [scheme.primary, scheme.tertiary],
      1 => [scheme.tertiary, scheme.secondary],
      2 => [scheme.secondary, scheme.primary],
      _ => [scheme.primary, scheme.secondary],
    };
  }
}
