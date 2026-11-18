import 'package:flutter_gms_demo/core/models/guidance_program.dart';
import 'package:flutter_gms_demo/data/in_memory/seed_guidance_programs.dart';

abstract interface class GuidanceProgramRepository {
  Future<List<GuidanceProgram>> getAllPrograms();
  Future<void> saveProgram(GuidanceProgram program);
  Future<void> deleteProgram(String id);

  Future<List<GuidanceScheduleTag>> getAllTags();
  Future<void> saveTag(GuidanceScheduleTag tag);
  Future<void> deleteTag(String id);
}

class InMemoryGuidanceProgramRepository implements GuidanceProgramRepository {
  InMemoryGuidanceProgramRepository()
    : _programs = {for (final p in seedGuidancePrograms()) p.id: p},
      _tags = {for (final t in seedGuidanceScheduleTags) t.id: t};

  final Map<String, GuidanceProgram> _programs;
  final Map<String, GuidanceScheduleTag> _tags;

  @override
  Future<List<GuidanceProgram>> getAllPrograms() async =>
      _programs.values.toList(growable: false);
  @override
  Future<void> saveProgram(GuidanceProgram p) async => _programs[p.id] = p;
  @override
  Future<void> deleteProgram(String id) async => _programs.remove(id);

  @override
  Future<List<GuidanceScheduleTag>> getAllTags() async =>
      _tags.values.toList(growable: false);
  @override
  Future<void> saveTag(GuidanceScheduleTag t) async => _tags[t.id] = t;
  @override
  Future<void> deleteTag(String id) async => _tags.remove(id);
}
