import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_notifier.freezed.dart';
part 'notifications_notifier.g.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String toUserId,
    required String fromUserId,
    required String message,
    @Default(false) bool isRead,
    required DateTime createdAt,
  }) = _AppNotification;
}

@Riverpod(keepAlive: true)
class AppNotifications extends _$AppNotifications {
  @override
  List<AppNotification> build() => const <AppNotification>[];

  /// Record one notification for a single recipient.
  void notifyOne({
    required String toUserId,
    required String fromUserId,
    required String message,
  }) {
    state = [
      AppNotification(
        id: 'n-${DateTime.now().microsecondsSinceEpoch}-$toUserId',
        toUserId: toUserId,
        fromUserId: fromUserId,
        message: message,
        createdAt: DateTime.now(),
      ),
      ...state,
    ];
  }

  /// Record one notification per recipient in [toUserIds].
  /// Skips the sender so you don't notify yourself.
  void notifyMany({
    required Iterable<String> toUserIds,
    required String fromUserId,
    required String message,
  }) {
    final Set<String> recipients = toUserIds.toSet()..remove(fromUserId);
    if (recipients.isEmpty) return;

    final now = DateTime.now();
    final newItems = <AppNotification>[
      for (final id in recipients)
        AppNotification(
          id: 'n-${now.microsecondsSinceEpoch}-$id',
          toUserId: id,
          fromUserId: fromUserId,
          message: message,
          createdAt: now,
        ),
    ];
    state = [...newItems, ...state];
  }

  void markRead(String id) {
    state = [for (final n in state) n.id == id ? n.copyWith(isRead: true) : n];
  }

  void markAllReadFor(String userId) {
    state = [
      for (final n in state)
        n.toUserId == userId ? n.copyWith(isRead: true) : n,
    ];
  }

  /// Unread count for the bell badge.
  int unreadCountFor(String userId) =>
      state.where((n) => n.toUserId == userId && !n.isRead).length;
}
