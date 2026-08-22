import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';
import '../room_setup/new_project_sheet.dart';

/// E8: Demo qo'llanma — video/animation placeholder, a 5-step numbered
/// list of how the app works end-to-end, and "O'zim sinab ko'raman"
/// which opens A3 (the new-project entry sheet) directly.
class E8TutorialTourScreen extends StatelessWidget {
  const E8TutorialTourScreen({super.key});

  static const _steps = [
    'Xona qo\'shish — LiDAR, 360° yoki qo\'lda o\'lchash',
    'Xonaning hozirgi holatini tanlash',
    'Rail bilan devor, pol va mebelni bezash',
    'Elektr va santexnikani oxirida rejalashtirish',
    'Smetani ko\'rish va materiallarni sotib olish',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: DesignTokens.backgroundLight,
        elevation: 0,
        title: const Text('Demo qo\'llanma', style: DesignTokens.heading3),
      ),
      body: ListView(
        padding: const EdgeInsets.all(DesignTokens.screenPaddingHorizontal),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: DesignTokens.darkBg,
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: DesignTokens.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: DesignTokens.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spacingSm),
                    Text(
                      'Videoni ko\'rish',
                      style: DesignTokens.body2.copyWith(
                        color: DesignTokens.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: DesignTokens.spacingXl),
          for (var i = 0; i < _steps.length; i++) ...[
            _StepRow(number: i + 1, text: _steps[i]),
            if (i != _steps.length - 1)
              const SizedBox(height: DesignTokens.spacingMd),
          ],
          const SizedBox(height: DesignTokens.spacingXl),
          SizedBox(
            width: double.infinity,
            height: DesignTokens.buttonHeightLarge,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.accentOrange,
              ),
              onPressed: () => showNewProjectSheet(context),
              child: const Text('O\'zim sinab ko\'raman'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: DesignTokens.primaryBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: DesignTokens.caption.copyWith(
                color: DesignTokens.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: DesignTokens.spacingMd),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: DesignTokens.spacingXs),
            child: Text(text, style: DesignTokens.body2),
          ),
        ),
      ],
    );
  }
}
