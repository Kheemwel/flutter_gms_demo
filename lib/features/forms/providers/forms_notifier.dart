import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/form.dart';
import 'package:flutter_gms_demo/data/in_memory/forms_repository.dart';

part 'forms_notifier.g.dart';

@Riverpod(keepAlive: true)
FormsRepository formsRepository(Ref ref) => InMemoryFormsRepository();

class Forms extends _$Forms {
  late FormsRepository _repo;

  @override
  List<Form> build() {
    _repo = ref.watch(formsRepositoryProvider);
    Future<void>.microtask(() async {
      state = await _repo.getAll();
    });
    return const <Form>[];
  }

  Form? byId(String id) {
    for (final Form f in state) {
      if (f.id == id) return f;
    }
    return null;
  }

  Future<void> add(Form form) async {
    await _repo.save(form);
    state = [...state, form];
  }

  Future<void> update(Form updated) async {
    await _repo.save(updated);
    state = [for (final f in state) f.id == updated.id ? updated : f];
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    state = state.where((f) => f.id != id).toList(growable: false);
  }

  /// Merge field values into a form. Only touches fields the caller
  /// has permission to edit (matches the original Livewire's
  /// per-role field set).
  Future<void> mergeFields({
    required String formId,
    required Map<String, String> updates,
  }) async {
    final Form? form = byId(formId);
    if (form == null) return;

    final merged = <String, String>{..._dataFields(form.data), ...updates};

    final FormData updatedData = switch (form.data) {
      HomeVisitationFormData d => d.copyWith(fields: merged) as FormData,
      ViolationFormData d => d.copyWith(fields: merged) as FormData,
    };

    final FormStatus nextStatus = _computeStatus(form.formType, updatedData);

    await update(form.copyWith(data: updatedData, status: nextStatus));
  }

  /// Set a signature for a signer role.
  Future<void> setSignature({
    required String formId,
    required SignerRole role,
    required String signatureDataUrl,
  }) async {
    final Form? form = byId(formId);
    if (form == null) return;

    final FormData updatedData = switch (form.data) {
      HomeVisitationFormData d => d.copyWith(
        signatures: {...d.signatures, role: signatureDataUrl},
      ) as FormData,
      ViolationFormData d => d.copyWith(
        signatures: {...d.signatures, role: signatureDataUrl},
      ) as FormData,
    };

    final FormStatus nextStatus = _computeStatus(form.formType, updatedData);

    await update(form.copyWith(data: updatedData, status: nextStatus));
  }

  Map<String, String> _dataFields(FormData data) => switch (data) {
    HomeVisitationFormData d => d.fields,
    ViolationFormData d => d.fields,
  };

  /// Completion = all required fields filled AND all required signers
  /// have signed. This is the fix over the original's "count non-null
  /// fields" logic, which counted optional fields and never verified
  /// signatures.
  FormStatus _computeStatus(FormType type, FormData data) {
    final Map<String, String> fields = _dataFields(data);
    final Set<String> requiredFieldKeys = Form.fieldsFor(type)
        .where((s) => s.required)
        .map((s) => s.key)
        .toSet();
    for (final key in requiredFieldKeys) {
      if ((fields[key] ?? '').trim().isEmpty) {
        return FormStatus.incomplete;
      }
    }

    final Map<SignerRole, String> signatures = switch (data) {
      HomeVisitationFormData d => d.signatures,
      ViolationFormData d => d.signatures,
    };
    final Set<SignerRole> requiredSigners = Form.requiredSignersFor(type);
    for (final role in requiredSigners) {
      if ((signatures[role] ?? '').isEmpty) {
        return FormStatus.incomplete;
      }
    }
    return FormStatus.complete;
  }
}
