import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../config/design_tokens.dart';
import '../../providers/masters_provider.dart';

/// U1: Ustalar map view — craftsman pins color-coded by trade, search,
/// profession filter chips, map/list toggle. Privacy rule: pins show
/// approximate area only (no exact address) — enforced by only ever
/// rendering [MockMaster.areaName] + distance, never a street address.
class U1MastersIntroScreen extends ConsumerStatefulWidget {
  const U1MastersIntroScreen({super.key});

  @override
  ConsumerState<U1MastersIntroScreen> createState() =>
      _U1MastersIntroScreenState();
}

class _U1MastersIntroScreenState extends ConsumerState<U1MastersIntroScreen> {
  Trade? _filter;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final masters = ref.watch(mockMastersProvider).where((m) {
      if (_filter != null && m.trade != _filter) return false;
      if (_query.isNotEmpty &&
          !m.master.name.toLowerCase().contains(_query.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(41.2995, 69.2401),
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.tamir_uy.tamir_uy_mobile_flutter',
                ),
                MarkerLayer(
                  markers: [
                    for (final m in masters)
                      if (m.master.latitude != null &&
                          m.master.longitude != null)
                        Marker(
                          point: LatLng(
                            m.master.latitude!,
                            m.master.longitude!,
                          ),
                          width: 44,
                          height: 44,
                          child: GestureDetector(
                            onTap: () => _showPinSheet(context, m),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(m.trade.colorValue),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: DesignTokens.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  m.trade.emoji,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.spacingMd,
                    ),
                    decoration: BoxDecoration(
                      color: DesignTokens.white,
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusFull,
                      ),
                      boxShadow: [DesignTokens.shadowCard],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Qanday usta kerak?',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => setState(() => _query = value),
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacingSm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _TradeChip(
                          label: 'Barchasi',
                          selected: _filter == null,
                          onTap: () => setState(() => _filter = null),
                        ),
                        for (final trade in Trade.values)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: DesignTokens.spacingSm,
                            ),
                            child: _TradeChip(
                              label: '${trade.emoji} ${trade.label}',
                              selected: _filter == trade,
                              onTap: () => setState(() => _filter = trade),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: DesignTokens.spacingMd,
            top: 140,
            child: SafeArea(
              child: FloatingActionButton.small(
                onPressed: () => context.push('/masters/u3'),
                backgroundColor: DesignTokens.white,
                child: const Icon(
                  Icons.view_list,
                  color: DesignTokens.primaryBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPinSheet(BuildContext context, MockMaster m) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => _PinSheet(master: m),
    );
  }
}

class _TradeChip extends StatelessWidget {
  const _TradeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: DesignTokens.white,
      selectedColor: DesignTokens.primaryBlue,
      labelStyle: DesignTokens.caption.copyWith(
        color: selected ? DesignTokens.white : DesignTokens.textDark,
      ),
    );
  }
}

/// U2: selected-pin bottom sheet.
class _PinSheet extends StatelessWidget {
  const _PinSheet({required this.master});

  final MockMaster master;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spacingLg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(master.trade.colorValue),
                    child: Text(
                      master.master.name[0],
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  if (master.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: DesignTokens.successGreen,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: DesignTokens.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(master.master.name, style: DesignTokens.subtitle1),
                    Text(
                      '${master.trade.emoji} ${master.trade.label}',
                      style: DesignTokens.body2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingMd),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: DesignTokens.accentOrange,
                size: 16,
              ),
              Text(
                ' ${master.master.rating} (${master.master.reviewCount} sharh)',
                style: DesignTokens.caption,
              ),
              const SizedBox(width: DesignTokens.spacingMd),
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: DesignTokens.textGray,
              ),
              Text(
                master.master.distanceKm != null
                    ? ' ${master.areaName} · ~${master.master.distanceKm} km'
                    : ' ${master.areaName}',
                style: DesignTokens.caption,
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacingLg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push('/masters/u4', extra: master);
              },
              child: const Text('Profilni ko\'rish'),
            ),
          ),
        ],
      ),
    );
  }
}
