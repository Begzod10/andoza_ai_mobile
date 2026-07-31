import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// U3: Request Booking
/// Submit booking request with project details and scope
class U3RequestBookingScreen extends ConsumerStatefulWidget {
  const U3RequestBookingScreen({super.key});

  @override
  ConsumerState<U3RequestBookingScreen> createState() =>
      _U3RequestBookingScreenState();
}

class _U3RequestBookingScreenState
    extends ConsumerState<U3RequestBookingScreen> {
  final _scopeController = TextEditingController();
  final _budgetController = TextEditingController();
  final _dateController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _scopeController.dispose();
    _budgetController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      context.go('/masters/u5');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Booking'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contractor info
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing12),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: DesignTokens.primaryBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          DesignTokens.radiusSm,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: DesignTokens.primaryBlue,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spacing12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alisher Karimov',
                            style: DesignTokens.subtitle2.copyWith(
                              color: DesignTokens.text,
                            ),
                          ),
                          const SizedBox(height: DesignTokens.spacing4),
                          Text(
                            'Flooring & Tiles Specialist',
                            style: DesignTokens.caption.copyWith(
                              color: DesignTokens.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Project details
              Text(
                'Project Details',
                style: DesignTokens.subtitle1.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),

              // Project scope
              Text(
                'Scope of Work',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing8),
              TextField(
                controller: _scopeController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe your project scope and requirements...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.all(DesignTokens.spacing12),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Budget
              Text(
                'Estimated Budget (UZS)',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing8),
              TextField(
                controller: _budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g., 5,000,000',
                  prefixText: '₽ ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing12,
                    vertical: DesignTokens.spacing12,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing16),

              // Start date
              Text(
                'Preferred Start Date',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing8),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Select date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: DesignTokens.spacing12,
                    vertical: DesignTokens.spacing12,
                  ),
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(const Duration(days: 7)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 180)),
                  );
                  if (date != null) {
                    _dateController.text = date.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Additional options
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
                      'Additional Information',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: null),
                        const SizedBox(width: DesignTokens.spacing8),
                        Expanded(
                          child: Text(
                            'Contractor can visit for site survey',
                            style: DesignTokens.bodyMedium.copyWith(
                              color: DesignTokens.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: null),
                        const SizedBox(width: DesignTokens.spacing8),
                        Expanded(
                          child: Text(
                            'I have design/blueprint files to share',
                            style: DesignTokens.bodyMedium.copyWith(
                              color: DesignTokens.text,
                            ),
                          ),
                        ),
                      ],
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
          onPressed: _isSubmitting ? () {} : _submitRequest,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DesignTokens.spacing12,
            ),
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit Request'),
          ),
        ),
      ),
    );
  }
}
