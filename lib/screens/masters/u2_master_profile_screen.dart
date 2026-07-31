import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// U2: Master/Contractor Profile
/// View detailed contractor profile, portfolio, and reviews
class U2MasterProfileScreen extends ConsumerWidget {
  const U2MasterProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contractor Profile'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile header
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: DesignTokens.primaryBlue.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(
                              DesignTokens.radiusMd,
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            color: DesignTokens.primaryBlue,
                            size: 48,
                          ),
                        ),
                        const SizedBox(width: DesignTokens.spacing16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alisher Karimov',
                                style: DesignTokens.heading3.copyWith(
                                  color: DesignTokens.text,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing4),
                              Text(
                                'Flooring & Tiles Specialist',
                                style: DesignTokens.bodyMedium.copyWith(
                                  color: DesignTokens.textSecondary,
                                ),
                              ),
                              const SizedBox(height: DesignTokens.spacing8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outlined,
                                    size: 18,
                                    color: DesignTokens.accentOrange,
                                  ),
                                  const SizedBox(width: DesignTokens.spacing4),
                                  Text(
                                    '4.9 (48 reviews)',
                                    style: DesignTokens.caption.copyWith(
                                      color: DesignTokens.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Stats
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(label: 'Projects', value: '156'),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _StatCard(label: 'Years', value: '12'),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  Expanded(
                    child: _StatCard(label: 'Verified', value: 'Yes'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // About
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Text(
                    'Professional flooring installer with 12 years of experience. Specializes in ceramic tiles, natural stone, and modern finishes. Certified in international standards. Committed to quality workmanship and customer satisfaction.',
                    style: DesignTokens.bodyMedium.copyWith(
                      color: DesignTokens.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Services
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Services',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  Wrap(
                    spacing: DesignTokens.spacing8,
                    runSpacing: DesignTokens.spacing8,
                    children: [
                      _ServiceTag(label: 'Tile Installation'),
                      _ServiceTag(label: 'Flooring'),
                      _ServiceTag(label: 'Grouting'),
                      _ServiceTag(label: 'Surface Prep'),
                      _ServiceTag(label: 'Waterproofing'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Recent reviews
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Reviews',
                    style: DesignTokens.subtitle1.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ReviewCard(
                    author: 'Diyor Mirzaev',
                    rating: 5,
                    text:
                        'Excellent work! Finished on time and very professional.',
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ReviewCard(
                    author: 'Nodira Suleymanova',
                    rating: 5,
                    text: 'Perfect attention to detail. Highly recommended!',
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: ElevatedButton(
          onPressed: () => context.go('/masters/u3'),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: DesignTokens.spacing12),
            child: Text('Request This Contractor'),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: DesignTokens.heading3.copyWith(
              color: DesignTokens.primaryBlue,
            ),
          ),
          const SizedBox(height: DesignTokens.spacing4),
          Text(
            label,
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTag extends StatelessWidget {
  const _ServiceTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spacing12,
        vertical: DesignTokens.spacing8,
      ),
      decoration: BoxDecoration(
        color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
        border: Border.all(
          color: DesignTokens.primaryBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: DesignTokens.caption.copyWith(color: DesignTokens.primaryBlue),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.author,
    required this.rating,
    required this.text,
  });

  final String author;
  final int rating;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacing12),
      decoration: BoxDecoration(
        border: Border.all(color: DesignTokens.border),
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                author,
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: i < rating
                        ? DesignTokens.accentOrange
                        : DesignTokens.border,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: DesignTokens.spacing8),
          Text(
            text,
            style: DesignTokens.bodyMedium.copyWith(
              color: DesignTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
