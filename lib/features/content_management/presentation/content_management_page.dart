import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/site_content.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/content_management/providers/site_content_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class ContentManagementPage extends HookConsumerWidget {
  const ContentManagementPage({super.key});

  static const List<String> _palettes = [
    'indigo',
    'teal',
    'rose',
    'amber',
    'green',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SiteContent content = ref.watch(siteContentProvider);

    final TextEditingController titleCtrl = useTextEditingController(
      text: content.title,
    );
    final TextEditingController subtitleCtrl = useTextEditingController(
      text: content.subtitle,
    );
    final TextEditingController schoolCtrl = useTextEditingController(
      text: content.schoolName,
    );
    final ValueNotifier<String> palette = useState<String>(content.logoPreset);
    final ValueNotifier<bool> saved = useState<bool>(true);

    // Keep saved in sync when any field changes.
    useEffect(() {
      void listener() {
        final bool dirty =
            titleCtrl.text != content.title ||
            subtitleCtrl.text != content.subtitle ||
            schoolCtrl.text != content.schoolName ||
            palette.value != content.logoPreset;
        saved.value = !dirty;
      }

      titleCtrl.addListener(listener);
      subtitleCtrl.addListener(listener);
      schoolCtrl.addListener(listener);
      listener(); // run once on setup
      return () {
        titleCtrl.removeListener(listener);
        subtitleCtrl.removeListener(listener);
        schoolCtrl.removeListener(listener);
      };
    }, [content, palette.value]);

    Future<void> save() async {
      final UserAccount? me = ref.read(authProvider);
      final SiteContent updated = content.copyWith(
        title: titleCtrl.text.trim(),
        subtitle: subtitleCtrl.text.trim(),
        schoolName: schoolCtrl.text.trim(),
        logoPreset: palette.value,
      );
      ref.read(siteContentProvider.notifier).update(updated);
      ref
          .read(auditLogsProvider.notifier)
          .log(
            userAccountId: me?.id ?? 'system',
            userFullName: me?.fullName,
            action: 'Update Site Content',
            description: 'Updated website title/subtitle/school/logo.',
          );
      saved.value = true;
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Site content saved.')));
      }
    }

    return AppPageScaffold(
      title: 'Content Management',
      subtitle:
          'Configure the public landing page. Changes take effect '
          'immediately on the landing screen.',
      actions: [
        FilledButton.icon(
          onPressed: saved.value ? null : save,
          icon: const Icon(Icons.save_rounded),
          label: const Text('Save'),
        ),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Card(
              title: 'Logo',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _LogoSwatch(preset: palette.value, size: 72),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Upload lands in a later batch. Pick a preset '
                          'for now.',
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final p in _palettes)
                        GestureDetector(
                          onTap: () => palette.value = p,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: palette.value == p
                                    ? context.colorScheme.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _LogoSwatch(preset: p, size: 40),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            _Card(
              title: 'Content',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      prefixIcon: Icon(Icons.title_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: subtitleCtrl,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Subtitle',
                      prefixIcon: Icon(Icons.notes_rounded),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: schoolCtrl,
                    decoration: const InputDecoration(
                      labelText: 'School name',
                      prefixIcon: Icon(Icons.school_outlined),
                    ),
                  ),
                ],
              ),
            ),
            _Card(
              title: 'Preview',
              child: _Preview(
                titleCtrl: titleCtrl,
                subtitleCtrl: subtitleCtrl,
                schoolCtrl: schoolCtrl,
                logoPreset: palette.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: context.textTheme.titleSmall),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoSwatch extends StatelessWidget {
  const _LogoSwatch({required this.preset, required this.size});
  final String preset;
  final double size;

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = switch (preset) {
      'teal' => [Colors.teal, Colors.green],
      'rose' => [Colors.pink, Colors.deepOrange],
      'amber' => [Colors.amber, Colors.orange],
      'green' => [Colors.green, Colors.lightGreen],
      _ => [context.colorScheme.primary, context.colorScheme.tertiary],
    };
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
        Icons.school_rounded,
        size: size * 0.5,
        color: Colors.white.withValues(alpha: 0.9),
      ),
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    required this.titleCtrl,
    required this.subtitleCtrl,
    required this.schoolCtrl,
    required this.logoPreset,
  });

  final TextEditingController titleCtrl;
  final TextEditingController subtitleCtrl;
  final TextEditingController schoolCtrl;
  final String logoPreset;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.3,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _LogoSwatch(preset: logoPreset, size: 56),
          const SizedBox(height: 12),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: schoolCtrl,
            builder: (_, v, _) => Text(
              v.text.isEmpty ? 'School name' : v.text,
              style: context.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: titleCtrl,
            builder: (_, v, _) => Text(
              v.text.isEmpty ? 'Title' : v.text,
              style: context.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: subtitleCtrl,
            builder: (_, v, _) => Text(
              v.text.isEmpty ? 'Subtitle' : v.text,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
