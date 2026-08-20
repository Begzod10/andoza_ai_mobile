import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../config/design_tokens.dart';
import '../../providers/masters_provider.dart';

/// U4: full craftsman profile — stat cards, portfolio, services, a
/// location mini-map showing only the approximate zone (never an exact
/// address, per spec's privacy rule), and reviews. Footer:
/// "Smetani yuborish" (primary).
class U4ReviewRatingScreen extends ConsumerWidget {
  const U4ReviewRatingScreen({this.master, super.key});

  final MockMaster? master;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = master ?? ref.watch(mockMastersProvider).first;

    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Builder(
                      builder: (context) {
                        final initial = CircleAvatar(
                          radius: 44,
                          backgroundColor: Color(m.trade.colorValue),
                          child: Text(
                            m.master.name[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        );
                        final url = m.master.avatar;
                        if (url == null) return initial;
                        return ClipOval(
                          child: Image.network(
                            url,
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => initial,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: DesignTokens.spacingMd),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${m.trade.emoji} ${m.trade.label}',
                          style: DesignTokens.subtitle1,
                        ),
                        if (m.isVerified) ...[
                          const SizedBox(width: DesignTokens.spacingXs),
                          const Icon(
                            Icons.verified,
                            color: DesignTokens.primaryBlue,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                    Text(m.master.name, style: DesignTokens.heading3),
                    if (m.isVerified)
                      Text(
                        '✓ Tasdiqlangan',
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.successGreen,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '${m.master.rating}',
                      label: 'reyting',
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: _StatCard(
                      value: '${m.master.reviewCount}',
                      label: 'sharh',
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacingSm),
                  Expanded(
                    child: _StatCard(
                      value: '${m.experienceYears * 40}',
                      label: 'ishlar',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              Text('Portfolio', style: DesignTokens.subtitle1),
              const SizedBox(height: DesignTokens.spacingSm),
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: DesignTokens.spacingSm),
                  itemBuilder: (_, _) => Container(
                    width: 90,
                    decoration: BoxDecoration(
                      color: DesignTokens.borderGrayAlt,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusMd,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingLg),
              Text('Xizmatlar', style: DesignTokens.subtitle1),
              const SizedBox(height: DesignTokens.spacingSm),
              _ServiceRow(label: '${m.trade.label} ishlari'),
              const _ServiceRow(label: 'Konsultatsiya'),
              const SizedBox(height: DesignTokens.spacingLg),
              Text('Joylashuv', style: DesignTokens.subtitle1),
              const SizedBox(height: DesignTokens.spacingXs),
              Text(
                m.master.distanceKm != null
                    ? '${m.areaName} · ~${m.master.distanceKm} km'
                    : m.areaName,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              SizedBox(
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(
                        m.master.latitude ?? 41.2995,
                        m.master.longitude ?? 69.2401,
                      ),
                      initialZoom: 12,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.none,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'com.tamir_uy.tamir_uy_mobile_flutter',
                      ),
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: LatLng(
                              m.master.latitude ?? 41.2995,
                              m.master.longitude ?? 69.2401,
                            ),
                            radius: 800,
                            useRadiusInMeter: true,
                            color: Color(
                              m.trade.colorValue,
                            ).withValues(alpha: 0.2),
                            borderColor: Color(m.trade.colorValue),
                            borderStrokeWidth: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingXl),
              SizedBox(
                width: double.infinity,
                height: DesignTokens.buttonHeightLarge,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DesignTokens.accentOrange,
                  ),
                  onPressed: () => context.push('/masters/u5', extra: m),
                  child: const Text('Smetani yuborish'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Xabar yozish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: DesignTokens.white,
        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        border: Border.all(color: DesignTokens.borderGray),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: DesignTokens.subtitle1.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          Text(
            label,
            style: DesignTokens.caption.copyWith(color: DesignTokens.textGray),
          ),
        ],
      ),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DesignTokens.spacingXs),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 16,
            color: DesignTokens.successGreen,
          ),
          const SizedBox(width: DesignTokens.spacingSm),
          Text(label, style: DesignTokens.body2),
        ],
      ),
    );
  }
}
