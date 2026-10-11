import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/design_tokens.dart';
import '../../l10n/app_localizations.dart';

/// OSM's tile usage policy (https://operations.osmfoundation.org/policies/tiles/)
/// requires a valid User-Agent naming the app and visible attribution on
/// every map showing tile.openstreetmap.org tiles. Use [osmTileLayer] and
/// [OsmAttribution] together inside a [FlutterMap]'s `children`.
const osmCopyrightUrl = 'https://www.openstreetmap.org/copyright';

/// The real Android applicationId / iOS bundle id, so OSM can identify (and
/// contact) us instead of blocking an anonymous client.
const osmUserAgentPackageName = 'andozaai.com';

TileLayer osmTileLayer() => TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: osmUserAgentPackageName,
);

/// "© OpenStreetMap contributors" pinned to the map's bottom-right corner;
/// tapping it opens the OSM copyright page in the browser.
class OsmAttribution extends StatelessWidget {
  const OsmAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!.mapAttribution;
    return Align(
      alignment: Alignment.bottomRight,
      child: Semantics(
        link: true,
        label: text,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => launchUrl(
            Uri.parse(osmCopyrightUrl),
            mode: LaunchMode.externalApplication,
          ),
          child: ColoredBox(
            color: DesignTokens.white.withValues(alpha: 0.85),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              child: Text(
                text,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textDark,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
