import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';

/// U5: Booking Confirmation
/// Confirmation and details after booking request submitted
class U5BookingConfirmationScreen extends ConsumerWidget {
  const U5BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DesignTokens.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Success icon
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignTokens.success.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80,
                    color: DesignTokens.success,
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing24),

              // Success message
              Text(
                'Request Submitted!',
                style: DesignTokens.heading3.copyWith(color: DesignTokens.text),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacing12),
              Text(
                'Your booking request has been sent to the contractor.',
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Request details
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Request Details',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing16),
                    _DetailRow(label: 'Request ID', value: 'REQ-2026-001847'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(label: 'Contractor', value: 'Alisher Karimov'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(label: 'Service', value: 'Flooring & Tiles'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(label: 'Budget', value: '5,000,000 UZS'),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Requested Start',
                      value: 'August 15, 2026',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _DetailRow(
                      label: 'Status',
                      value: 'Pending Review',
                      isStatus: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // What happens next
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
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
                      'What Happens Next?',
                      style: DesignTokens.subtitle2.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _TimelineStep(
                      number: 1,
                      title: 'Contractor Reviews',
                      description:
                          'The contractor will review your request within 24 hours',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _TimelineStep(
                      number: 2,
                      title: 'Site Survey',
                      description:
                          'They may contact you to schedule a site visit',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _TimelineStep(
                      number: 3,
                      title: 'Confirmation',
                      description:
                          'Once confirmed, you\'ll receive a booking confirmation',
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    _TimelineStep(
                      number: 4,
                      title: 'Project Starts',
                      description: 'Work begins on the agreed date',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // Contact info
              Container(
                padding: const EdgeInsets.all(DesignTokens.spacing16),
                decoration: BoxDecoration(
                  border: Border.all(color: DesignTokens.border),
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Keep in Touch',
                      style: DesignTokens.subtitle1.copyWith(
                        color: DesignTokens.text,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.message_outlined),
                      label: const Text('Chat with Contractor'),
                    ),
                    const SizedBox(height: DesignTokens.spacing12),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.phone_outlined),
                      label: const Text('Call Contractor'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),

              // CTA buttons
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  child: Text('Back to Home'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing12),
              OutlinedButton(
                onPressed: () => context.go('/masters/u1'),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: DesignTokens.spacing12,
                  ),
                  child: Text('Find Another Contractor'),
                ),
              ),
              const SizedBox(height: DesignTokens.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isStatus = false,
  });

  final String label;
  final String value;
  final bool isStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: DesignTokens.bodyMedium.copyWith(
            color: DesignTokens.textSecondary,
          ),
        ),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DesignTokens.spacing8,
              vertical: DesignTokens.spacing4,
            ),
            decoration: BoxDecoration(
              color: DesignTokens.accentOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
              border: Border.all(
                color: DesignTokens.accentOrange.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              value,
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.accentOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Text(
            value,
            style: DesignTokens.subtitle2.copyWith(
              color: DesignTokens.text,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.number,
    required this.title,
    required this.description,
  });

  final int number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DesignTokens.primaryBlue,
          ),
          child: Center(
            child: Text(
              '$number',
              style: DesignTokens.caption.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: DesignTokens.subtitle2.copyWith(
                  color: DesignTokens.text,
                ),
              ),
              const SizedBox(height: DesignTokens.spacing4),
              Text(
                description,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
