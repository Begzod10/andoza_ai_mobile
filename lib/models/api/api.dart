/// Barrel for the backend-mirroring API models (wire format).
///
/// These map 1:1 onto the FastAPI pydantic schemas and are kept separate from
/// the app's client-side domain models under `lib/models/`.
library;

export 'ai.dart';
export 'apartment.dart';
export 'catalog.dart';
export 'decoration.dart';
export 'delta.dart';
export 'electrical.dart';
export 'estimate.dart';
export 'material_offer.dart';
export 'order.dart';
export 'room_create.dart';
export 'room_out.dart';
export 'room_state.dart';
export 'usta.dart';
export 'wallpaper.dart';
