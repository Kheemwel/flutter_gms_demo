import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_users.dart';

/// Contract for user-account persistence.
/// Later batches can swap the in-memory impl for an HTTP one
/// without touching the notifier or any widget.
abstract interface class UserAccountsRepository {
  Future<List<UserAccount>> getAll();
  Future<UserAccount?> getById(String id);
  Future<void> save(UserAccount user);
  Future<void> delete(String id);
}

class InMemoryUserAccountsRepository implements UserAccountsRepository {
  InMemoryUserAccountsRepository([List<UserAccount>? initial])
    : _store = {for (final u in (initial ?? seedUsers)) u.id: u};

  final Map<String, UserAccount> _store;

  @override
  Future<List<UserAccount>> getAll() async =>
      _store.values.toList(growable: false);

  @override
  Future<UserAccount?> getById(String id) async => _store[id];

  @override
  Future<void> save(UserAccount user) async {
    _store[user.id] = user;
  }

  @override
  Future<void> delete(String id) async {
    _store.remove(id);
  }
}
