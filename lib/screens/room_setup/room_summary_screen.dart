import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/design_tokens.dart';

/// Room completion model
class RoomSummary {
  final String roomName;
  final String roomType;
  final double width;
  final double length;
  final double height;
  final int doorsCount;
  final int windowsCount;
  final int photosCount;
  final int pointsCount;
  final DateTime createdAt;
  final bool isComplete;

  RoomSummary({
    required this.roomName,
    required this.roomType,
    required this.width,
    required this.length,
    required this.height,
    required this.doorsCount,
    required this.windowsCount,
    required this.photosCount,
    required this.pointsCount,
    required this.createdAt,
    required this.isComplete,
  });
}

/// Room Summary Completion (A9)
/// Shows final summary of room scan and allows export/sharing
class RoomSummaryScreen extends ConsumerStatefulWidget {
  final RoomSummary? summary;

  const RoomSummaryScreen({
    Key? key,
    this.summary,
  }) : super(key: key);

  @override
  ConsumerState<RoomSummaryScreen> createState() => _RoomSummaryScreenState();
}

class _RoomSummaryScreenState extends ConsumerState<RoomSummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: DesignTokens.animationNormal,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock summary data if not provided
    final summary = widget.summary ??
        RoomSummary(
          roomName: 'Living Room',
          roomType: 'Living Room',
          width: 4.5,
          length: 5.2,
          height: 2.8,
          doorsCount: 2,
          windowsCount: 3,
          photosCount: 12,
          pointsCount: 45000,
          createdAt: DateTime.now(),
          isComplete: true,
        );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: DesignTokens.backgroundLight,
        title: const Text('Room Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: DesignTokens.backgroundLight,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success banner
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(DesignTokens.spacingLg),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        DesignTokens.successGreen,
                        DesignTokens.successGreen.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: DesignTokens.iconXxl,
                        color: DesignTokens.white,
                      ),
                      const SizedBox(height: DesignTokens.spacingMd),
                      Text(
                        'Scan Complete!',
                        style: DesignTokens.heading2.copyWith(
                          color: DesignTokens.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: DesignTokens.spacingSm),
                      Text(
                        'Your room has been successfully scanned and processed',
                        style: DesignTokens.body1.copyWith(
                          color: DesignTokens.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            // Room info card
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacingMd),
              decoration: BoxDecoration(
                color: DesignTokens.white,
                border: Border.all(color: DesignTokens.borderGray),
                borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary.roomName,
                            style: DesignTokens.heading3,
                          ),
                          const SizedBox(height: DesignTokens.spacingSm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DesignTokens.spacingSm,
                              vertical: DesignTokens.spacingSm,
                            ),
                            decoration: BoxDecoration(
                              color: DesignTokens.accentOrange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                DesignTokens.radiusMd,
                              ),
                            ),
                            child: Text(
                              summary.roomType,
                              style: DesignTokens.caption.copyWith(
                                color: DesignTokens.accentOrange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.layers_outlined,
                        size: DesignTokens.iconXl,
                        color: DesignTokens.primaryBlue.withOpacity(0.3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            // Metrics grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: DesignTokens.spacingMd,
              mainAxisSpacing: DesignTokens.spacingMd,
              childAspectRatio: 1.2,
              children: [
                _MetricCard(
                  icon: Icons.straighten,
                  label: 'Dimensions',
                  value:
                      '${summary.width.toStringAsFixed(1)}×${summary.length.toStringAsFixed(1)}×${summary.height.toStringAsFixed(1)}m',
                  color: DesignTokens.primaryBlue,
                ),
                _MetricCard(
                  icon: Icons.door_front_door,
                  label: 'Doors',
                  value: '${summary.doorsCount}',
                  color: DesignTokens.accentOrange,
                ),
                _MetricCard(
                  icon: Icons.window,
                  label: 'Windows',
                  value: '${summary.windowsCount}',
                  color: DesignTokens.successGreen,
                ),
                _MetricCard(
                  icon: Icons.cloud_outlined,
                  label: 'Point Cloud',
                  value: '${(summary.pointsCount / 1000).toStringAsFixed(0)}K',
                  color: const Color(0xFF8B5CF6),
                ),
                _MetricCard(
                  icon: Icons.camera_alt_outlined,
                  label: 'Photos',
                  value: '${summary.photosCount}',
                  color: const Color(0xFFEC4899),
                ),
                _MetricCard(
                  icon: Icons.check_circle,
                  label: 'Status',
                  value: 'Complete',
                  color: DesignTokens.successGreen,
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            // Details section
            Text(
              'Scan Details',
              style: DesignTokens.subtitle1,
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              label: 'Created',
              value: _formatDate(summary.createdAt),
            ),
            _DetailRow(
              icon: Icons.square_foot,
              label: 'Floor Area',
              value:
                  '${(summary.width * summary.length).toStringAsFixed(2)} m²',
            ),
            _DetailRow(
              icon: Icons.layers_outlined,
              label: 'Volume',
              value:
                  '${(summary.width * summary.length * summary.height).toStringAsFixed(2)} m³',
            ),
            const SizedBox(height: DesignTokens.spacingLg),
            // Action buttons
            SizedBox(
              width: double.infinity,
              height: DesignTokens.buttonHeightLarge,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Exporting room data...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Export 3D Model'),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            SizedBox(
              width: double.infinity,
              height: DesignTokens.buttonHeightMedium,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing room data...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Share Room'),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingMd),
            SizedBox(
              width: double.infinity,
              height: DesignTokens.buttonHeightMedium,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                icon: const Icon(Icons.home),
                label: const Text('Add Another Room'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: DesignTokens.primaryBlue.withOpacity(0.1),
                  foregroundColor: DesignTokens.primaryBlue,
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spacingXl),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.spacingMd),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: DesignTokens.iconLg,
            color: color,
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            label,
            style: DesignTokens.caption.copyWith(
              color: DesignTokens.textGray,
            ),
          ),
          const SizedBox(height: DesignTokens.spacingSm),
          Text(
            value,
            style: DesignTokens.subtitle2.copyWith(
              color: color,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spacingMd),
      child: Row(
        children: [
          Icon(
            icon,
            size: DesignTokens.iconMd,
            color: DesignTokens.textGray,
          ),
          const SizedBox(width: DesignTokens.spacingMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: DesignTokens.caption.copyWith(
                  color: DesignTokens.textGray,
                ),
              ),
              const SizedBox(height: DesignTokens.spacingSm),
              Text(
                value,
                style: DesignTokens.body1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
