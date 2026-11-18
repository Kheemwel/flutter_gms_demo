import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/data/in_memory/guidance_program_repository.dart';

part 'guidance_program_notifier.g.dart';

@Riverpod(keepAlive: true)
GuidanceProgramRepository guidanceProgramRepository(Ref ref) =>
    InMemoryGuidanceProgramRepository();

@Riverpod(keepAlive: true)
class GuidancePrograms extends _$GuidancePrograms {
  late GuidanceProgramRepository _repo;

  @override
  List<GuidanceProgram> build() {
    _repo = ref.watch(guidanceProgramRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllPrograms();
    });
    return const <GuidanceProgram>[];
  }

  GuidanceProgram? byId(String id) {
    for (final GuidanceProgram p in state) {
      if (p.id == id) return p;
    }
    return null;
  }

  Future<void> add(GuidanceProgram p) async {
    await _repo.saveProgram(p);
    state = [...state, p];
  }

  Future<void> update(GuidanceProgram updated) async {
    await _repo.saveProgram(updated);
    state = [for (final p in state) p.id == updated.id ? updated : p];
  }

  Future<void> delete(String id) async {
    await _repo.deleteProgram(id);
    state = state.where((p) => p.id != id).toList(growable: false);
  }
}

@Riverpod(keepAlive: true)
class GuidanceScheduleTags extends _$GuidanceScheduleTags {
  late GuidanceProgramRepository _repo;

  @override
  List<GuidanceScheduleTag> build() {
    _repo = ref.watch(guidanceProgramRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAllTags();
    });
    return const <GuidanceScheduleTag>[];
  }

  GuidanceScheduleTag? byId(String id) {
    for (final GuidanceScheduleTag t in state) {
      if (t.id == id) return t;
    }
    return null;
  }

  Future<void> add(GuidanceScheduleTag t) async {
    await _repo.saveTag(t);
    state = [...state, t];
  }

  Future<void> update(GuidanceScheduleTag updated) async {
    await _repo.saveTag(updated);
    state = [for (final t in state) t.id == updated.id ? updated : t];
  }

  Future<void> delete(String id) async {
    await _repo.deleteTag(id);
    state = state.where((t) => t.id != id).toList(growable: false);
  }
}
