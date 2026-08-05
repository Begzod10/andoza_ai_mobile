// Hide Flutter's Material widget so the unqualified `Material` here refers to
// our backend catalog model; we still get Color from this import.
import 'package:flutter/material.dart' hide Material;

import '../models/api/catalog.dart';
import '../widgets/room_3d_rail.dart';

/// Parses a backend `color_hex` (e.g. `#FFFFFF` or `FFFFFF`) into a [Color].
/// Returns null for missing/malformed values so callers can fall back to a
/// default swatch colour.
Color? hexToColor(String? hex) {
  if (hex == null) return null;
  var h = hex.replaceFirst('#', '').trim();
  if (h.length == 6) h = 'FF$h'; // assume fully opaque
  if (h.length != 8) return null;
  final value = int.tryParse(h, radix: 16);
  return value == null ? null : Color(value);
}

/// Maps backend [Material]s into the decoration rail's [RailItem]s, using the
/// material's real name and colour. The material id is preserved as the rail
/// item id so a selection can be tied back to a catalog row later.
List<RailItem> materialsToRailItems(List<Material> materials) {
  return materials
      .map(
        (m) => RailItem(
          id: m.id,
          label: m.nameUz,
          color: hexToColor(m.colorHex),
        ),
      )
      .toList();
}
