import 'package:flutter_test/flutter_test.dart';
import 'package:tamir_uy_mobile_flutter/models/business_profile.dart';

void main() {
  test('a finished photo-model job carries the GLB key', () {
    final job = ModelJob.fromJson({
      'status': 'SUCCESS',
      'result': {'status': 'ok', 'key': 'photo-models/u/m.glb'},
    });
    expect(job.isDone, isTrue);
    expect(job.key, 'photo-models/u/m.glb');
  });

  test('a job the worker reports as failed is failed, not done', () {
    final job = ModelJob.fromJson({
      'status': 'SUCCESS',
      'result': {'status': 'failed', 'error': 'Rasm kontent siyosatiga mos kelmaydi'},
    });
    expect(job.isFailed, isTrue);
    expect(job.isDone, isFalse);
  });

  test('pending and started jobs are still working; FAILURE is failed', () {
    for (final s in ['PENDING', 'STARTED', 'RETRY']) {
      final job = ModelJob.fromJson({'status': s, 'result': null});
      expect(job.isDone || job.isFailed, isFalse, reason: s);
    }
    expect(ModelJob.fromJson({'status': 'FAILURE', 'result': null}).isFailed, isTrue);
  });
}
