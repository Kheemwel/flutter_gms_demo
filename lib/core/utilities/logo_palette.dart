import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:material_ui/material_ui.dart';

List<Color> logoPalette(BuildContext context, String preset) {
  return switch (preset) {
    'teal' => [Colors.teal, Colors.green],
    'rose' => [Colors.pink, Colors.deepOrange],
    'amber' => [Colors.amber, Colors.orange],
    'green' => [Colors.green, Colors.lightGreen],
    _ => [context.colorScheme.primary, context.colorScheme.tertiary],
  };
}
