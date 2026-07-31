import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// E6: Saved Estimates & History
/// View and manage saved project estimates
class E6SavedEstimatesScreen extends ConsumerWidget {
  const E6SavedEstimatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Estimates'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filter bar
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search estimates...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            DesignTokens.radiusMd,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacing12,
                          vertical: DesignTokens.spacing12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spacing12),
                  IconButton(icon: const Icon(Icons.tune), onPressed: () {}),
                ],
              ),
            ),

            // Estimates list
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                children: [
                  _EstimateCard(
                    title: 'Living Room Renovation',
                    date: 'July 28, 2026',
                    amount: '825,000 UZS',
                    status: 'Active',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _EstimateCard(
                    title: 'Kitchen Upgrade',
                    date: 'July 10, 2026',
                    amount: '1,200,000 UZS',
                    status: 'Approved',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _EstimateCard(
                    title: 'Bedroom Makeover',
                    date: 'June 25, 2026',
                    amount: '650,000 UZS',
                    status: 'Completed',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _EstimateCard(
                    title: 'Bathroom Renovation',
                    date: 'June 5, 2026',
                    amount: '750,000 UZS',
                    status: 'Completed',
                    onTap: () {},
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _EstimateCard(
                    title: 'Flooring Installation',
                    date: 'May 18, 2026',
                    amount: '500,000 UZS',
                    status: 'Completed',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
          ],
        ),
      ),
    );
  }
}

class _EstimateCard extends StatelessWidget {
  const _EstimateCard({
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.onTap,
  });

  final String title;
  final String date;
  final String amount;
  final String status;
  final VoidCallback onTap;

  Color _getStatusColor() {
    switch (status) {
      case 'Active':
        return DesignTokens.accentOrange;
      case 'Approved':
        return DesignTokens.success;
      case 'Completed':
        return DesignTokens.primaryBlue;
      default:
        return DesignTokens.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DesignTokens.spacing12),
        decoration: BoxDecoration(
          border: Border.all(color: DesignTokens.border),
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: DesignTokens.subtitle2.copyWith(
                      color: DesignTokens.text,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing8,
                    vertical: DesignTokens.spacing4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    border: Border.all(
                      color: _getStatusColor().withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    status,
                    style: DesignTokens.caption.copyWith(
                      color: _getStatusColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacing8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: DesignTokens.caption.copyWith(
                    color: DesignTokens.textSecondary,
                  ),
                ),
                Text(
                  amount,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('View'),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Share'),
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Export'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
