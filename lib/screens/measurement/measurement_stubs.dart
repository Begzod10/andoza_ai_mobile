import 'package:flutter/material.dart';
import '../../config/design_tokens.dart';

class MeasurementStub extends StatelessWidget {
  const MeasurementStub({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: DesignTokens.primary),
            const SizedBox(height: DesignTokens.spacing24),
            Text(
              title,
              style: DesignTokens.headingMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spacing12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spacing24),
              child: Text(
                description,
                style: DesignTokens.bodyMedium.copyWith(
                  color: DesignTokens.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing24),
            Container(
              padding: const EdgeInsets.all(DesignTokens.spacing16),
              decoration: BoxDecoration(
                color: DesignTokens.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
              ),
              child: Text(
                'Phase 1 - Under Development',
                style: DesignTokens.labelMedium.copyWith(
                  color: DesignTokens.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class A2CameraScreen extends StatelessWidget {
  const A2CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Camera Measurement',
      description: 'Position your phone to measure the room using camera',
    );
  }
}

class A3RoomNameScreen extends StatelessWidget {
  const A3RoomNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Room Name',
      description: 'Enter a name for this room',
    );
  }
}

class A4ManualDimensionsScreen extends StatelessWidget {
  const A4ManualDimensionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Manual Dimensions',
      description: 'Enter room width, length, and height',
    );
  }
}

class A5FurnitureScreen extends StatelessWidget {
  const A5FurnitureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Add Furniture',
      description: 'Select and place furniture in your room',
    );
  }
}

class A6LidarScreen extends StatelessWidget {
  const A6LidarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'LiDAR Scan',
      description: 'Use LiDAR sensor for precise 3D measurement',
    );
  }
}

class A7PhotoScreen extends StatelessWidget {
  const A7PhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Photo Measurement',
      description: 'Use reference objects for scale measurement',
    );
  }
}

class A8ReviewScreen extends StatelessWidget {
  const A8ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Review Measurement',
      description: 'Review and confirm your measurement data',
    );
  }
}

class A9SummaryScreen extends StatelessWidget {
  const A9SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MeasurementStub(
      title: 'Measurement Complete',
      description: 'Your room has been successfully measured',
    );
  }
}
