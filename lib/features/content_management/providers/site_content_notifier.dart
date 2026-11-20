import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_gms_demo/core/models/site_content.dart';

part 'site_content_notifier.g.dart';

@Riverpod(keepAlive: true)
class SiteContentNotifier extends _$SiteContentNotifier {
  @override
  SiteContent build() => SiteContent.defaults();

  void update(SiteContent updated) => state = updated;

  void reset() => state = SiteContent.defaults();
}
