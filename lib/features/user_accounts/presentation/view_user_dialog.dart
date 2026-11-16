import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_gms_demo/core/models/role.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/roles/providers/role_providers.dart';

class ViewUserDialog extends ConsumerWidget {
  const ViewUserDialog({super.key, required this.user});

  final UserAccount user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Role? role = ref.watch(roleByIdProvider(user.roleId));

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 640),
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
                      'User details',
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: context.colorScheme.primaryContainer,
                          child: Text(
                            _initials(user.fullName),
                            style: context.textTheme.titleLarge?.copyWith(
                              color: context.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.fullName,
                                style: context.textTheme.titleMedium,
                              ),
                              Text(
                                user.email,
                                style: context.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(
                          avatar: Icon(
                            role?.kind.icon ?? Icons.person_rounded,
                            size: 16,
                          ),
                          label: Text(role?.name ?? 'Unknown role'),
                        ),
                        Chip(
                          avatar: Icon(
                            user.isArchived
                                ? Icons.archive_rounded
                                : Icons.check_circle_rounded,
                            size: 16,
                          ),
                          label: Text(user.isArchived ? 'Archived' : 'Active'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _DetailRow(label: 'ID', value: user.id),
                    _DetailRow(
                      label: 'Total logins',
                      value: '${user.totalLogin}',
                    ),
                    _DetailRow(
                      label: 'Last login',
                      value: user.lastLogin == null
                          ? 'Never'
                          : _formatDate(user.lastLogin!),
                    ),
                    if (user.rememberToken != null)
                      const _DetailRow(
                        label: 'Remember token',
                        value: 'Set (demo only)',
                      ),
                    ..._profileDetails(user.profile),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _profileDetails(UserProfile profile) {
    return switch (profile) {
      StudentProfile() => [
        const _SectionHeader('Student profile'),
        _DetailRow(label: 'LRN', value: profile.lrn),
        _DetailRow(label: 'Grade level', value: profile.gradeLevel.label),
        _DetailRow(
          label: 'School level',
          value: profile.gradeLevel.schoolLevel.label,
        ),
      ],
      ParentProfile() => [
        const _SectionHeader('Parent profile'),
        _DetailRow(label: 'Children', value: profile.childIds.join(', ')),
      ],
      PrincipalProfile() => [
        const _SectionHeader('Principal profile'),
        _DetailRow(label: 'Position', value: profile.position.label),
      ],
      AdminProfile() || GuidanceProfile() || TeacherProfile() => const [],
    };
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${_pad(d.month)}-${_pad(d.day)} '
      '${_pad(d.hour)}:${_pad(d.minute)}';

  String _pad(int n) => n.toString().padLeft(2, '0');

  String _initials(String fullName) {
    final List<String> parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(label, style: context.textTheme.titleSmall),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: context.textTheme.bodySmall),
          ),
          Expanded(child: Text(value, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
