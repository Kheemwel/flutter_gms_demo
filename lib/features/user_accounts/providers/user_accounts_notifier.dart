import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/user_account.dart';
import 'package:flutter_gms_demo/data/in_memory/user_accounts_repository.dart';

part 'user_accounts_notifier.g.dart';

@Riverpod(keepAlive: true)
UserAccountsRepository userAccountsRepository(Ref ref) {
  return InMemoryUserAccountsRepository();
}

@Riverpod(keepAlive: true)
class UserAccounts extends _$UserAccounts {
  late UserAccountsRepository _repo;

  @override
  List<UserAccount> build() {
    _repo = ref.watch(userAccountsRepositoryProvider);
    // Kick off async load; when it resolves we set state.
    Future<void>.microtask(() async {
      final List<UserAccount> loaded = await _repo.getAll();
      state = loaded;
    });
    return const <UserAccount>[];
  }

  UserAccount? byId(String id) {
    for (final UserAccount u in state) {
      if (u.id == id) return u;
    }
    return null;
  }

  Future<void> add(UserAccount user) async {
    await _repo.save(user);
    state = [...state, user];
  }

  Future<void> update(UserAccount updated) async {
    await _repo.save(updated);
    state = [for (final u in state) u.id == updated.id ? updated : u];
  }

  Future<void> archive(String id) async {
    final UserAccount? user = byId(id);
    if (user == null) return;
    await update(user.copyWith(isArchived: true));
  }

  Future<void> unarchive(String id) async {
    final UserAccount? user = byId(id);
    if (user == null) return;
    await update(user.copyWith(isArchived: false));
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    state = state.where((u) => u.id != id).toList(growable: false);
  }
}
