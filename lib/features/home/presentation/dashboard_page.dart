import 'package:flutter_gms_demo/core/models/user_role.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart' hide Form;
import 'package:go_router/go_router.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/core/extensions/user_role_x.dart';
import 'package:flutter_gms_demo/core/models/audit_log.dart';
import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/core/models/form_request.dart';
import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/core/models/user_profile.dart';
import 'package:flutter_gms_demo/features/audit_trail/providers/audit_log_notifier.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/forms/providers/form_requests_providers.dart';
import 'package:flutter_gms_demo/features/forms/providers/forms_providers.dart';
import 'package:flutter_gms_demo/features/guidance_program/providers/guidance_program_providers.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/home/presentation/dashboard_widgets.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    if (me == null) return const SizedBox.shrink();

    final RoleKind kind = switch (me.profile) {
      AdminProfile() => RoleKind.admin,
      GuidanceProfile() => RoleKind.guidance,
      StudentProfile() => RoleKind.student,
      ParentProfile() => RoleKind.parent,
      TeacherProfile() => RoleKind.teacher,
      PrincipalProfile() => RoleKind.principal,
    };

    return AppPageScaffold(
      title: _greeting(me, kind),
      subtitle: _tagline(kind),
      actions: [RolePill(label: kind.label, icon: kind.icon)],
      child: ListView(
        children: [
          const SizedBox(height: 4),
          _KpiStrip(me: me, kind: kind),
          const SizedBox(height: 16),
          _TwoColumn(
            left: _NeedsAttentionSection(me: me, kind: kind),
            right: _UpcomingSection(me: me),
          ),
          const SizedBox(height: 16),
          _TwoColumn(
            left: _QuickActionsSection(kind: kind),
            right: _ActivitySection(me: me, kind: kind),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _greeting(UserAccount me, RoleKind kind) {
    final int hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 18
        ? 'Good afternoon'
        : 'Good evening';
    return '$greeting, ${me.firstName}';
  }

  String _tagline(RoleKind kind) => switch (kind) {
    RoleKind.admin =>
      'Here\'s the state of the system. What would you like to look at?',
    RoleKind.guidance => 'Here\'s what needs your attention today.',
    RoleKind.teacher => 'Here\'s what you\'re tracking with your students.',
    RoleKind.student => 'Here\'s a summary of your forms and upcoming events.',
    RoleKind.parent => 'Here\'s what your children need you to look at.',
    RoleKind.principal => 'Forms awaiting your signature and upcoming events.',
  };
}

// ─────────────────────────────────────────────────────────────────────
// KPI strip
// ─────────────────────────────────────────────────────────────────────

class _KpiStrip extends ConsumerWidget {
  const _KpiStrip({required this.me, required this.kind});
  final UserAccount me;
  final RoleKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ({List<Form> completed, List<Form> toFill}) forms = ref.watch(
      myFormsProvider,
    );
    final List<FormRequest> requests = ref.watch(formRequestsProvider);
    final int pendingRequests = requests
        .where((r) => r.status == FormRequestStatus.pending)
        .length;

    final cards = <Widget>[];

    switch (kind) {
      case RoleKind.guidance:
      case RoleKind.admin:
        cards.addAll([
          KpiCard(
            value: pendingRequests,
            label: 'Pending requests',
            icon: Icons.rule_rounded,
            onTap: () => context.go('/app/approval'),
          ),
          KpiCard(
            value: forms.toFill.length,
            label: 'Forms in progress',
            icon: Icons.edit_document,
            color: Theme.of(context).colorScheme.tertiary,
            onTap: () => context.go('/app/forms'),
          ),
          KpiCard(
            value: forms.completed.length,
            label: 'Completed forms',
            icon: Icons.check_circle_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
            onTap: () => context.go('/app/forms'),
          ),
        ]);
      case RoleKind.teacher:
        final List<FormRequest> mine = ref.watch(myRequestsProvider);
        cards.addAll([
          KpiCard(
            value: mine
                .where((r) => r.status == FormRequestStatus.pending)
                .length,
            label: 'Pending requests',
            icon: Icons.outbox_rounded,
            onTap: () => context.go('/app/request-forms'),
          ),
          KpiCard(
            value: forms.toFill.length,
            label: 'Forms to fill',
            icon: Icons.edit_document,
            color: Theme.of(context).colorScheme.tertiary,
            onTap: () => context.go('/app/forms'),
          ),
        ]);
      case RoleKind.student:
      case RoleKind.parent:
      case RoleKind.principal:
        cards.addAll([
          KpiCard(
            value: forms.toFill.length,
            label: 'Forms to fill',
            icon: Icons.edit_document,
            onTap: () => context.go('/app/forms'),
          ),
          KpiCard(
            value: forms.completed.length,
            label: 'Completed forms',
            icon: Icons.check_circle_outline_rounded,
            color: Theme.of(context).colorScheme.tertiary,
            onTap: () => context.go('/app/forms'),
          ),
        ]);
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(child: cards[i]),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// "Needs your attention" — role-aware list
// ─────────────────────────────────────────────────────────────────────

class _NeedsAttentionSection extends ConsumerWidget {
  const _NeedsAttentionSection({required this.me, required this.kind});
  final UserAccount me;
  final RoleKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> rows = _buildRows(context, ref);
    return SectionCard(
      title: 'Needs your attention',
      icon: Icons.priority_high_rounded,
      child: rows.isEmpty
          ? const InlineEmpty(message: 'You\'re all caught up.')
          : Column(children: rows),
    );
  }

  List<Widget> _buildRows(BuildContext context, WidgetRef ref) {
    final rows = <Widget>[];

    // Pending requests (guidance + admin only).
    if (kind == RoleKind.guidance || kind == RoleKind.admin) {
      final List<FormRequest> pending = ref.watch(
        requestsByStatusProvider(FormRequestStatus.pending),
      );
      for (final FormRequest r in pending.take(3)) {
        rows.add(
          AttentionRow(
            icon: Icons.rule_rounded,
            title: '${r.displayId} · ${r.formType.label}',
            subtitle: 'From ${r.payload.teacherName}',
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.go('/app/approval'),
          ),
        );
      }
    }

    // Incomplete forms addressed to me.
    final ({List<Form> completed, List<Form> toFill}) forms = ref.watch(
      myFormsProvider,
    );
    for (final Form f in forms.toFill.take(3)) {
      rows.add(
        AttentionRow(
          icon: Icons.edit_document,
          title: '${f.displayId} · ${f.formType.label}',
          subtitle: 'In progress — needs your signature',
          trailing: const Icon(Icons.chevron_right_rounded),
          accent: Theme.of(context).colorScheme.tertiary,
          onTap: () => context.go('/app/forms'),
        ),
      );
    }

    // Unread notifications.
    final List<AppNotification> notifs = ref.watch(appNotificationsProvider);
    final int unread = notifs
        .where((n) => n.toUserId == me.id && !n.isRead)
        .length;
    if (unread > 0) {
      rows.add(
        AttentionRow(
          icon: Icons.notifications_active_rounded,
          title: '$unread unread notification${unread == 1 ? '' : 's'}',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => context.go('/app/notifications'),
        ),
      );
    }

    return rows;
  }
}

// ─────────────────────────────────────────────────────────────────────
// "Upcoming schedule"
// ─────────────────────────────────────────────────────────────────────

class _UpcomingSection extends ConsumerWidget {
  const _UpcomingSection({required this.me});
  final UserAccount me;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<GuidanceProgram> all = ref.watch(visibleProgramsProvider);
    final Map<String, GuidanceScheduleTag> tags = ref.watch(
      guidanceTagByIdProvider,
    );
    final now = DateTime.now();

    final List<GuidanceProgram> upcoming =
        all.where((p) => p.programStart.isAfter(now)).toList(growable: false)
          ..sort((a, b) => a.programStart.compareTo(b.programStart));
    final List<GuidanceProgram> next = upcoming.take(5).toList(growable: false);

    return SectionCard(
      title: 'Upcoming schedule',
      icon: Icons.event_rounded,
      action: TextButton(
        onPressed: () => context.go('/app/program'),
        child: const Text('View calendar'),
      ),
      child: next.isEmpty
          ? const InlineEmpty(message: 'No upcoming events.')
          : Column(
              children: [
                for (final p in next)
                  _UpcomingRow(
                    program: p,
                    tag: tags[p.scheduleTagId],
                    onTap: () => context.go('/app/program'),
                  ),
              ],
            ),
    );
  }
}

class _UpcomingRow extends StatelessWidget {
  const _UpcomingRow({
    required this.program,
    required this.tag,
    required this.onTap,
  });

  final GuidanceProgram program;
  final GuidanceScheduleTag? tag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final Color accent = tag == null ? scheme.primary : Color(tag!.colorValue);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(program.title, style: context.textTheme.bodyMedium),
                    Text(
                      shortDateTime(program.programStart),
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (!program.isPublic)
                Icon(
                  Icons.lock_outline_rounded,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// "Quick actions" — role-aware
// ─────────────────────────────────────────────────────────────────────

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({required this.kind});
  final RoleKind kind;

  @override
  Widget build(BuildContext context) {
    final List<_QuickAction> actions = _actionsFor(kind);
    return SectionCard(
      title: 'Quick actions',
      icon: Icons.flash_on_rounded,
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          for (final a in actions)
            SizedBox(
              width: 180,
              child: QuickActionTile(
                icon: a.icon,
                label: a.label,
                color: a.color,
                onTap: () => context.go(a.route),
              ),
            ),
        ],
      ),
    );
  }

  List<_QuickAction> _actionsFor(RoleKind kind) {
    switch (kind) {
      case RoleKind.admin:
        return const [
          _QuickAction(
            icon: Icons.people_rounded,
            label: 'User accounts',
            route: '/app/user-accounts',
          ),
          _QuickAction(
            icon: Icons.shield_rounded,
            label: 'Roles & privileges',
            route: '/app/roles',
          ),
          _QuickAction(
            icon: Icons.rule_rounded,
            label: 'Approvals',
            route: '/app/approval',
          ),
          _QuickAction(
            icon: Icons.history_rounded,
            label: 'Audit trail',
            route: '/app/audit-trail',
          ),
        ];
      case RoleKind.guidance:
        return const [
          _QuickAction(
            icon: Icons.edit_document,
            label: 'Fill out forms',
            route: '/app/forms',
          ),
          _QuickAction(
            icon: Icons.rule_rounded,
            label: 'Approve requests',
            route: '/app/approval',
          ),
          _QuickAction(
            icon: Icons.calendar_month_rounded,
            label: 'Schedule events',
            route: '/app/program',
          ),
          _QuickAction(
            icon: Icons.groups_rounded,
            label: 'Student records',
            route: '/app/students',
          ),
        ];
      case RoleKind.teacher:
        return const [
          _QuickAction(
            icon: Icons.outbox_rounded,
            label: 'Request a form',
            route: '/app/request-forms',
          ),
          _QuickAction(
            icon: Icons.edit_document,
            label: 'Fill out forms',
            route: '/app/forms',
          ),
          _QuickAction(
            icon: Icons.calendar_month_rounded,
            label: 'Guidance program',
            route: '/app/program',
          ),
        ];
      case RoleKind.student:
        return const [
          _QuickAction(
            icon: Icons.edit_document,
            label: 'Forms to fill',
            route: '/app/forms',
          ),
          _QuickAction(
            icon: Icons.folder_shared_rounded,
            label: 'My records',
            route: '/app/student-records',
          ),
          _QuickAction(
            icon: Icons.calendar_month_rounded,
            label: 'Guidance program',
            route: '/app/program',
          ),
        ];
      case RoleKind.parent:
        return const [
          _QuickAction(
            icon: Icons.edit_document,
            label: 'Forms to fill',
            route: '/app/forms',
          ),
          _QuickAction(
            icon: Icons.family_restroom_rounded,
            label: 'My child records',
            route: '/app/child-records',
          ),
          _QuickAction(
            icon: Icons.calendar_month_rounded,
            label: 'Guidance program',
            route: '/app/program',
          ),
        ];
      case RoleKind.principal:
        return const [
          _QuickAction(
            icon: Icons.edit_document,
            label: 'Forms to sign',
            route: '/app/forms',
          ),
          _QuickAction(
            icon: Icons.calendar_month_rounded,
            label: 'Guidance program',
            route: '/app/program',
          ),
        ];
    }
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
  }) : color = null;
  final IconData icon;
  final String label;
  final String route;
  final Color? color;
}

// ─────────────────────────────────────────────────────────────────────
// "Recent activity" — audit for admin/guidance, notifications otherwise
// ─────────────────────────────────────────────────────────────────────

class _ActivitySection extends ConsumerWidget {
  const _ActivitySection({required this.me, required this.kind});
  final UserAccount me;
  final RoleKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showAudit = kind == RoleKind.admin || kind == RoleKind.guidance;

    if (showAudit) {
      final List<AuditLog> logs = ref
          .watch(auditLogsProvider)
          .take(5)
          .toList(growable: false);
      return SectionCard(
        title: 'Recent activity',
        icon: Icons.history_rounded,
        action: TextButton(
          onPressed: () => context.go('/app/audit-trail'),
          child: const Text('View all'),
        ),
        child: logs.isEmpty
            ? const InlineEmpty(message: 'No activity logged yet.')
            : Column(children: [for (final a in logs) _AuditRow(entry: a)]),
      );
    }

    final List<AppNotification> notifs = ref
        .watch(appNotificationsProvider)
        .where((n) => n.toUserId == me.id)
        .take(5)
        .toList(growable: false);
    return SectionCard(
      title: 'Recent notifications',
      icon: Icons.notifications_none_rounded,
      action: TextButton(
        onPressed: () => context.go('/app/notifications'),
        child: const Text('View all'),
      ),
      child: notifs.isEmpty
          ? const InlineEmpty(message: 'No notifications yet.')
          : Column(
              children: [
                for (final n in notifs)
                  AttentionRow(
                    icon: Icons.notifications_rounded,
                    title: n.message,
                    subtitle: relativeTime(n.createdAt),
                  ),
              ],
            ),
    );
  }
}

class _AuditRow extends StatelessWidget {
  const _AuditRow({required this.entry});
  final AuditLog entry;

  @override
  Widget build(BuildContext context) {
    return AttentionRow(
      icon: Icons.bolt_rounded,
      title: entry.description,
      subtitle:
          '${entry.userFullName ?? 'System'} · '
          '${relativeTime(entry.createdAt)}',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Layout helper: two columns on wide, stacked on narrow
// ─────────────────────────────────────────────────────────────────────

class _TwoColumn extends StatelessWidget {
  const _TwoColumn({required this.left, required this.right});
  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Column(children: [left, const SizedBox(height: 16), right]);
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: left),
            const SizedBox(width: 16),
            Expanded(flex: 2, child: right),
          ],
        );
      },
    );
  }
}
