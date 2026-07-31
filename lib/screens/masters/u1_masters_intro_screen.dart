import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// U1: Masters/Contractors Search & Discovery
/// Browse and search for available contractors by specialty
class U1MastersIntroScreen extends ConsumerStatefulWidget {
  const U1MastersIntroScreen({super.key});

  @override
  ConsumerState<U1MastersIntroScreen> createState() =>
      _U1MastersIntroScreenState();
}

class _U1MastersIntroScreenState extends ConsumerState<U1MastersIntroScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Contractors'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search contractors...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing12,
                    vertical: DesignTokens.spacing12,
                  ),
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),

            // Filter chips
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Filter by Specialty',
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.text,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _selectedFilter == 'all',
                      onTap: () => setState(() => _selectedFilter = 'all'),
                    ),
                    const SizedBox(width: DesignTokens.spacing8),
                    _FilterChip(
                      label: 'Flooring',
                      isSelected: _selectedFilter == 'flooring',
                      onTap: () => setState(() => _selectedFilter = 'flooring'),
                    ),
                    const SizedBox(width: DesignTokens.spacing8),
                    _FilterChip(
                      label: 'Electrical',
                      isSelected: _selectedFilter == 'electrical',
                      onTap: () =>
                          setState(() => _selectedFilter = 'electrical'),
                    ),
                    const SizedBox(width: DesignTokens.spacing8),
                    _FilterChip(
                      label: 'Plumbing',
                      isSelected: _selectedFilter == 'plumbing',
                      onTap: () => setState(() => _selectedFilter = 'plumbing'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),

            // Contractors list
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Text(
                'Available Contractors (12)',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DesignTokens.spacing16,
              ),
              child: Column(
                children: [
                  _ContractorCard(
                    name: 'Alisher Karimov',
                    specialty: 'Flooring & Tiles',
                    rating: 4.9,
                    reviewCount: 48,
                    price: '50,000-80,000',
                    onTap: () => context.go('/masters/u2'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ContractorCard(
                    name: 'Rashid Abdullaev',
                    specialty: 'Electrical Systems',
                    rating: 4.8,
                    reviewCount: 35,
                    price: '40,000-70,000',
                    onTap: () => context.go('/masters/u2'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ContractorCard(
                    name: 'Dilshod Usmonov',
                    specialty: 'Painting & Finishing',
                    rating: 4.7,
                    reviewCount: 52,
                    price: '30,000-50,000',
                    onTap: () => context.go('/masters/u2'),
                  ),
                  const SizedBox(height: DesignTokens.spacing12),
                  _ContractorCard(
                    name: 'Mirza Rakhimov',
                    specialty: 'General Renovation',
                    rating: 4.6,
                    reviewCount: 41,
                    price: '60,000-100,000',
                    onTap: () => context.go('/masters/u2'),
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: DesignTokens.surface,
      selectedColor: DesignTokens.primaryBlue.withValues(alpha: 0.2),
      side: BorderSide(
        color: isSelected ? DesignTokens.primaryBlue : DesignTokens.border,
      ),
    );
  }
}

class _ContractorCard extends StatelessWidget {
  const _ContractorCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.onTap,
  });

  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String price;
  final VoidCallback onTap;

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
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Icon(
                    Icons.person,
                    color: DesignTokens.primaryBlue,
                    size: 32,
                  ),
                ),
                const SizedBox(width: DesignTokens.spacing12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: DesignTokens.subtitle2.copyWith(
                          color: DesignTokens.text,
                        ),
                      ),
                      const SizedBox(height: DesignTokens.spacing4),
                      Text(
                        specialty,
                        style: DesignTokens.caption.copyWith(
                          color: DesignTokens.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_outlined,
                      size: 16,
                      color: DesignTokens.accentOrange,
                    ),
                    const SizedBox(width: DesignTokens.spacing4),
                    Text(
                      '$rating ($reviewCount)',
                      style: DesignTokens.caption.copyWith(
                        color: DesignTokens.textSecondary,
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: DesignTokens.subtitle2.copyWith(
                    color: DesignTokens.primaryBlue,
                    fontWeight: FontWeight.bold,
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
