import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../config/design_tokens.dart';
import '../../providers/measurement_provider.dart';

class A3RoomNameScreen extends ConsumerStatefulWidget {
  const A3RoomNameScreen({super.key});

  @override
  ConsumerState<A3RoomNameScreen> createState() => _A3RoomNameScreenState();
}

class _A3RoomNameScreenState extends ConsumerState<A3RoomNameScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final currentName = ref.read(measurementProvider).roomName ?? '';
    _controller = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Room Name')),
      body: Padding(
        padding: const EdgeInsets.all(DesignTokens.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What\'s the name of this room?',
              style: DesignTokens.headingMedium.copyWith(
                color: DesignTokens.text,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing16),
            Text(
              'Give your room a name for easy reference',
              style: DesignTokens.bodyMedium.copyWith(
                color: DesignTokens.textSecondary,
              ),
            ),
            const SizedBox(height: DesignTokens.spacing32),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'e.g., Living Room, Bedroom, Kitchen',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: DesignTokens.spacing16,
                  vertical: DesignTokens.spacing12,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  ref.read(measurementProvider.notifier).setRoomName(value);
                }
              },
            ),
            const SizedBox(height: DesignTokens.spacing32),
            ElevatedButton(
              onPressed: _controller.text.isEmpty
                  ? null
                  : () {
                      // Save room name
                      ref.read(measurementProvider.notifier).setRoomName(_controller.text);

                      // Route based on selected method
                      final method = ref.read(measurementMethodProvider);
                      if (method == MeasurementMethod.camera) {
                        context.push('/measurement/a2');
                      } else {
                        context.push('/measurement/a4');
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: DesignTokens.primary,
                padding: const EdgeInsets.symmetric(
                  vertical: DesignTokens.spacing12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLarge),
                ),
              ),
              child: Text(
                'Next',
                style: DesignTokens.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
