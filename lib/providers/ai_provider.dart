import 'package:riverpod/riverpod.dart';

import '../repositories/ai_repository.dart';
import 'auth_provider.dart';

/// AI features repository (room-builder SSE + smeta explainer).
final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepository(ref.watch(apiClientProvider));
});
