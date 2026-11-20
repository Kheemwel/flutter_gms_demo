import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_gms_demo/core/extensions/theme_x.dart';
import 'package:flutter_gms_demo/features/auth/providers/auth_notifier.dart';
import 'package:flutter_gms_demo/features/notifications/providers/notifications_notifier.dart';
import 'package:flutter_gms_demo/features/user_accounts/providers/user_accounts_notifier.dart';
import 'package:flutter_gms_demo/shared/widgets/app_empty_state.dart';
import 'package:flutter_gms_demo/shared/widgets/app_page_scaffold.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserAccount? me = ref.watch(authProvider);
    if (me == null) return const SizedBox.shrink();

    final List<AppNotification> all = ref.watch(appNotificationsProvider);
    final List<UserAccount> users = ref.watch(userAccountsProvider);

    final List<AppNotification> mine = all.where((n) => n.toUserId == me.id).toList(growable: false)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final int unreadCount = mine.where((n) => !n.isRead).length;

    return AppPageScaffold(
      title: 'Notifications',
      subtitle: '${mine.length} total · $unreadCount unread',
      actions: [
        if (unreadCount > 0)
          OutlinedButton.icon(
            onPressed: () => ref
                .read(appNotificationsProvider.notifier)
                .markAllReadFor(me.id),
            icon: const Icon(Icons.done_all_rounded),
            label: const Text('Mark all read'),
          ),
      ],
      child: mine.isEmpty
          ? const AppEmptyState(
              icon: Icons.notifications_none_rounded,
              title: 'No notifications',
              message:
                  'Form requests, approvals, private schedules, and '
                  'other in-app events will appear here.',
            )
          : ListView.separated(
              itemCount: mine.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final AppNotification n = mine[i];
                final UserAccount? from = users
                    .where((u) => u.id == n.fromUserId)
                    .firstOrNull;
                return _NotificationTile(
                  notification: n,
                  fromName: from?.fullName ?? 'System',
                  onMarkRead: () => ref
                      .read(appNotificationsProvider.notifier)
                      .markRead(n.id),
                );
              },
            ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.fromName,
    required this.onMarkRead,
  });

  final AppNotification notification;
  final String fromName;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final bool unread = !notification.isRead;

    return Material(
      color: unread
          ? scheme.primaryContainer.withValues(alpha: 0.25)
          : scheme.surfaceContainerHighest.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: unread ? onMarkRead : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: unread
                    ? scheme.primary
                    : scheme.surfaceContainerHighest,
                child: Icon(
                  Icons.notifications_rounded,
                  size: 18,
                  color: unread ? scheme.onPrimary : scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.message,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: unread ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$fromName · ${_relative(notification.createdAt)}',
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (unread)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: scheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _relative(DateTime d) {
    final Duration diff = DateTime.now().difference(d);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }
}
