import 'package:freezed_annotation/freezed_annotation.dart';

part 'site_content.freezed.dart';

@freezed
abstract class SiteContent with _$SiteContent {
  const factory SiteContent({
    required String title,
    required String subtitle,
    required String schoolName,

    /// Preset gradient palette id ("indigo", "teal", …).
    /// Real logo upload lands in the assets batch.
    required String logoPreset,
  }) = _SiteContent;

  factory SiteContent.defaults() => const SiteContent(
    title: 'Flutter GMS Demo',
    subtitle: 'A showcase port of a guidance management system.',
    schoolName: 'Example School',
    logoPreset: 'indigo',
  );
}
