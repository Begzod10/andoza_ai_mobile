import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// U4: Review & Rating
/// Rate contractor and leave feedback after completed work
class U4ReviewRatingScreen extends ConsumerStatefulWidget {
  const U4ReviewRatingScreen({super.key});

  @override
  ConsumerState<U4ReviewRatingScreen> createState() =>
      _U4ReviewRatingScreenState();
}

class _U4ReviewRatingScreenState extends ConsumerState<U4ReviewRatingScreen> {
  int _rating = 0;
  final _reviewController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Contractor'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contractor info
              Center(
                child: Container(
                  padding: const EdgeInsets.all(DesignTokens.spacing16),
                  decoration: BoxDecoration(
                    border: Border.all(color: DesignTokens.border),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  child: Column(
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
                      const SizedBox(height: DesignTokens.spacing12),
                      Text(
                        'Alisher Karimov',
                        style: DesignTokens.subtitle1.copyWith(
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Rating section
              Text(
                'How would you rate your experience?',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () => setState(() => _rating = index + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignTokens.spacing8,
                        ),
                        child: Icon(
                          Icons.star,
                          size: 48,
                          color: index < _rating
                              ? DesignTokens.accentOrange
                              : DesignTokens.border,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Center(
                child: Text(
                  _rating > 0 ? 'Rating: $_rating / 5' : 'Tap to rate',
                  style: DesignTokens.subtitle2.copyWith(
                    color: _rating > 0
                        ? DesignTokens.accentOrange
                        : DesignTokens.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Review text
              Text(
                'Share your experience',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      'Tell us about your experience with this contractor. What went well? Any suggestions?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.all(DesignTokens.spacing12),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Criteria
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                decoration: BoxDecoration(
                  color: DesignTokens.primaryBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  border: Border.all(
                    color: DesignTokens.primaryBlue.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How would you rate these aspects?',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RatingCriterion(label: 'Quality of Work'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RatingCriterion(label: 'Communication'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RatingCriterion(label: 'Punctuality'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _RatingCriterion(label: 'Professionalism'),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Recommendation
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                ),
                child: Row(
                  children: [
                    Checkbox(value: true, onChanged: null),
                    const SizedBox(width: DesignTokens.spacing8),
                    Expanded(
                      child: Text(
                        'I would recommend this contractor',
                        style: DesignTokens.bodyMedium.copyWith(
                          color: DesignTokens.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing16),
        child: ElevatedButton(
          onPressed: _rating > 0 && !_isSubmitting ? _submitReview : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.spacing12,
            ),
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text('Submit Review'),
          ),
        ),
      ),
    );
  }
}

class _RatingCriterion extends StatefulWidget {
  const _RatingCriterion({required this.label});

  final String label;

  @override
  State<_RatingCriterion> createState() => _RatingCriterionState();
}

class _RatingCriterionState extends State<_RatingCriterion> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.label,
          style: DesignTokens.bodyMedium.copyWith(color: DesignTokens.text),
        ),
        Row(
          children: List.generate(
            5,
            (index) => GestureDetector(
              onTap: () => setState(() => _rating = index + 1),
              child: Icon(
                Icons.star,
                size: 20,
                color: index < _rating
                    ? DesignTokens.accentOrange
                    : DesignTokens.border,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
